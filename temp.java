@Override
public ArrayList<PTStatusTrackerAdminDTO> getPTStatusTrackerAdmin(int days, String dns_name, String status)
        throws UserDefinedException {
    ArrayList<PTStatusTrackerAdminDTO> pt_data = new ArrayList<PTStatusTrackerAdminDTO>();
    LOG.info("Inside PTInfrastructureDAOImpl | getPTStatusTrackerAdmin ");

    List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
    try {

        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("DAYS", days);
        parameters.addValue("DNS_NAME", dns_name);

        if (status.equals("WIP")) {
            rows = this.namedParameterJdbcTemplate
                    .queryForList(OracleQueryConstants.GET_PT_INFRASTRUCTURE_WIP.toString(), parameters);
        } else if (status.equals("COM")) {
            rows = this.namedParameterJdbcTemplate
                    .queryForList(OracleQueryConstants.GET_PT_INFRASTRUCTURE_COM.toString(), parameters);
        } else {
            rows = this.namedParameterJdbcTemplate
                    .queryForList(OracleQueryConstants.GET_PT_INFRASTRUCTURE_TOT.toString(), parameters);
        }

        PTStatusTrackerAdminDTO dto = new PTStatusTrackerAdminDTO();

        for (Map<String, Object> row : rows) {
            String setupName = row.get("setup_name").toString();
            String unitName = row.get("unitname").toString();
            String armId = row.get("arm_id").toString();
            String severity = row.get("severity").toString();
            int criticalC = 0, highC = 0, mediumC = 0, lowC = 0;

            if (severity != null && !severity.isEmpty()) {
                String[] severityArray = severity.split(",");
                for (String s : severityArray) {
                    String trimmedSeverity = s.trim();
                    if ("critical".equalsIgnoreCase(trimmedSeverity)) {
                        criticalC++;
                    } else if ("high".equalsIgnoreCase(trimmedSeverity)) {
                        highC++;
                    } else if ("medium".equalsIgnoreCase(trimmedSeverity)) {
                        mediumC++;
                    } else if ("low".equalsIgnoreCase(trimmedSeverity)) {
                        lowC++;
                    }
                }
            }

            // set DTO attributes
            dto.setSetupName(setupName);
            dto.setUnitName(unitName);
            dto.setArmId(armId);
            dto.setCritical(criticalC);
            dto.setHigh(highC);
            dto.setMedium(mediumC);
            dto.setLow(lowC);

            pt_data.add(dto);

        }

        return pt_data;

    } catch (DataAccessException e) {
        LOG.error("PTInfrastructureDAOImpl | DataAccessException in getPTStatusTrackerAdmin ", e);
        return pt_data;
    } catch (Exception e) {
        LOG.error("PTInfrastructureDAOImpl | Exception in getPTStatusTrackerAdmin ", e);
        return pt_data;
    }

}
