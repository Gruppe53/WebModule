package program;

import connect.ITerminalConnection;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import database.*;



public class Terminal implements ITerminal {
	
	private int okcount = 0;
	private ITerminalConnection con;
	private DBAccess dbAccess;
	private double taraTemp = 0;
	private double nettoTemp = 0;
	
	public Terminal(ITerminalConnection con) {
		this.con = con;
	}

	@Override
	public String terminalConnect(String host, String port) {
		if(con.terminalConnect(host, port))
			return getConnection();
		else
			return "Could not connect";
	}

	@Override
	public String terminalDisconnect() {
	con.terminalDisconnect();
		
		return getConnection();
	}

	@Override
	public String terminalRead() {
		String str = con.getTerminalResponse("S");
		
		return "På vægten er der nu: " + getDigit(str) + " " + getUnit(str);
	}

	@Override
	public String terminalTare() {
		String str = con.getTerminalResponse("T");
		
		return "vægten er tareret, taraen er: " + getDigit(str) + " " + getUnit(str);
	}

	@Override
	public String terminalZero() {
		con.getTerminalResponse("Z");
		
		return "Vægten er nulstillet.";
	}

	@Override
	public String terminalOkWeight(String productBatchNumber, String materialBatchId) throws Exception {
		
		if (okcount == 3){
			okcount = 0;
		}
		
		if (okcount == 0){
			okcount++;
			return terminalZero();
		}
		else 
		if (okcount == 1) {
			taraTemp = getCurrentWeight();
			okcount++;
			return terminalTare();
		}
		else {
			if(tolerableWeight(productBatchNumber, materialBatchId))
			nettoTemp = getCurrentWeight();
			dbAccess = new DBAccess();
			int rs;
			try {
			rs = dbAccess.doSqlUpdate("INSERT INTO pbcomponent VALUES('" + productBatchNumber + "', '" + materialBatchId +"', '" + nettoTemp + "', '" + taraTemp + "', '" + 1 + "')");
			System.out.println(rs);
			dbAccess.closeSqlNonRS();
			} catch (DALException e) {
				e.printStackTrace();
			}
			catch (SQLException e) {
				e.printStackTrace();
				}
			}
		okcount++;
		return terminalTare();
		}
		
		
	

	@Override
	public String terminalOkGetPrescription(String productBatchNumber) throws Exception {
		return getPrescription(productBatchNumber);
	}
	
	@Override
	public String terminalOkGetMaterialId(String materialBatchId) throws Exception {
		return getMaterialId(materialBatchId);
	}
	
	@Override
	public String terminalOkGetMaterialName(String materialBatchId) throws Exception {
		return getMaterialName(materialBatchId);
	}
	
	@Override
	public String getConnection() {
		return con.getHost() + ":" + con.getPort();
	}


	@Override
	public String terminalMessage(String msg) {
	con.getTerminalResponse("D " + msg);
		return "msg";
	}

	
	@Override
	public String terminalDisplay() {
		con.getTerminalResponse("DW");
		
		return "den aktuelle vægt vises nu på vægten.";
	}
	
	
	@Override
	public boolean tolerableWeight(String productBatchNumber, String materialBatchId) throws Exception {
		boolean tolerable = false;
		double weight = getCurrentWeight();
		double netto = getNetto(productBatchNumber, materialBatchId);
		double tolerance = getTolerance(productBatchNumber, materialBatchId);
			if( weight <= netto+(netto/100*tolerance) && weight >= netto-(netto/100*tolerance)){
				tolerable = true;
			}
			else {
				tolerable = false;
			}
		return tolerable;
	}
	
	
	@Override
	public double getCurrentWeight() {
		String res = con.getTerminalResponse("S");
		double weight = Double.parseDouble(getDigit(res));
		return weight;
	}

	
	private String getPrescription(String productBatchNumber) throws Exception {
		ResultSet prescriptionNumber = null;
		String prescription = null;
		dbAccess = new DBAccess();
		try {
			prescriptionNumber = dbAccess.doSqlQuery("SELECT pre_id FROM productbatch WHERE pb_id = '" + productBatchNumber + "'");
			if(prescriptionNumber.next()) {
				prescription = prescriptionNumber.getString("pre_id");
			}
		} 
		catch (DALException e) {
			e.printStackTrace();			
		}
		catch (SQLException f) {
			f.printStackTrace();
		}
		finally{
			try{
				dbAccess.closeSqlNonRS();
				prescriptionNumber.close();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return prescription;
	}
	
	private String getMaterialId(String materialBatchId) throws Exception{
		String materialIdNumber = materialBatchId; 
		ResultSet materialIdResultSet = null;
		String materialId = null;
		dbAccess = new DBAccess();
		try{
			materialIdResultSet = dbAccess.doSqlQuery("SELECT m_id FROM matbatch WHERE mb_id = '" + materialIdNumber + "'");
			if(materialIdResultSet.next()){
				materialId = materialIdResultSet.getString("m_id");
				
			}
		}
		catch (DALException e) {
			e.printStackTrace();
		}
		catch (SQLException f) {
			f.printStackTrace();
		}
		finally{
			try{
				dbAccess.closeSql();
				materialIdResultSet.close();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return materialId;
	}

	
	private String getMaterialName(String materialBatchId) throws Exception{
		String materialId = getMaterialId(materialBatchId);
		ResultSet materialNameResultSet = null;
		String materialName = null;
		dbAccess = new DBAccess();
		try{
			materialNameResultSet = dbAccess.doSqlQuery("SELECT m_name FROM materials WHERE m_id = '" + materialId + "'");
			if(materialNameResultSet.next()){
				materialName = materialNameResultSet.getString("m_name");
			}
		}
		catch (DALException e) {
			e.printStackTrace();
		}
		catch (SQLException f) {
			f.printStackTrace();
		}
		finally{
			try{
				dbAccess.closeSql();
				materialNameResultSet.close();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return materialName;
	}
	
	private double getNetto(String productBatchNumber, String materialBatchId) throws Exception{
		String materialId = getMaterialId(materialBatchId);
		String prescriptionId = getPrescription(productBatchNumber);
		ResultSet nettoResultSet = null;
		double nettoDouble = 0;
		dbAccess = new DBAccess();
		try{
			nettoResultSet = dbAccess.doSqlQuery("SELECT netto FROM precomponent WHERE pre_id = '" + prescriptionId + "' AND m_id = '" + materialId + "'");
			if(nettoResultSet.next()){
				nettoDouble = nettoResultSet.getDouble("netto");
			}
		}
		catch (DALException e) {
			e.printStackTrace();
		}
		catch (SQLException f) {
			f.printStackTrace();
		}
		finally{
			try{
				dbAccess.closeSql();
				nettoResultSet.close();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return nettoDouble;
	}

	private double getTolerance(String productBatchNumber, String materialBatchId) throws Exception{
		String materialId = getMaterialId(materialBatchId);
		String prescriptionId = getPrescription(productBatchNumber);
		ResultSet toleranceResultSet = null;
		double tolerancedouble = 0;
		dbAccess = new DBAccess();
		try{
			toleranceResultSet = dbAccess.doSqlQuery("SELECT tolerance FROM precomponent WHERE pre_id = '" + prescriptionId + "' AND m_id = '" + materialId + "'");
			if(toleranceResultSet.next()){
				tolerancedouble = toleranceResultSet.getDouble("tolerance");
			}
		}
		catch (DALException e) {
			e.printStackTrace();
		}
		catch (SQLException f) {
			f.printStackTrace();
		}
		finally{
			try{
				dbAccess.closeSql();
				toleranceResultSet.close();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return tolerancedouble;
	}
	
	private String getDigit(String str) {
		String res = "";
		
		Pattern p = Pattern.compile("-?[\\d+.\\d+]");
		Matcher m = p.matcher(str);
		
		while(m.find()) {
			res += m.group();
		}
		
		return res;
	}
	
	private String getUnit(String str) {
		return str.substring(str.length() - 2).trim();
	}
}
