CREATE OR REPLACE VIEW equipmgr_repairrcdview AS
 SELECT equipmgr_repairrcd.id,
    equipmgr_repairrcd.device_id,
    equipmgr_repairrcd.fromcompany,
    equipmgr_repairrcd.repaircompany,
    equipmgr_repairrcd.content,
    equipmgr_repairrcd.total,
    equipmgr_repairrcd.repairdate,
    equipmgr_repairrcd.endrepairdate,
    equipmgr_repairrcd.sendpeople,
    equipmgr_repairrcd.checkpeople,
    equipmgr_repairrcd.faulttype,
    equipmgr_repairrcd.fault,
    equipmgr_repairrcd.faultdesc,
    equipmgr_repairrcd.mtype,
    equipmgr_repairrcd.rtime,
    equipmgr_repairrcd.luser,
    equipmgr_repairrcd.recipient,
    equipmgr_repairrcd.checkwellno,
    equipmgr_repairrcd.checkwell,
    equipmgr_repairrcd.assetsno,
    equipmgr_repairrcd.repairplanno,
    repairer.factorytype,
    equipmgr_repairrcd.repairmethod
   FROM equipmgr_repairrcd
     JOIN equipmgr_repairer repairer ON repairer.name::text = equipmgr_repairrcd.repaircompany::text
UNION
 SELECT 0 AS id,
    fault.device_id,
    fromorg.name AS fromcompany,
    repairorg.name AS repaircompany,
    apply.content,
    repair.total,
    repair.repairdate,
    repair.endrepairdate,
    repair.sendpeople,
    repair.checkpeople,
    fault.faulttype,
    fault.fault,
    fault.faultdesc,
    repair.mtype,
    repair.rtime,
    repair.luser,
    repair.recipient,
    repair.checkwellno,
    repair.checkwell,
    repair.assetsno,
    repair.repairplanno,
    repairorg.factorytype,
    apply.repairmethod
   FROM equipmgr_repair repair
     JOIN equipmgr_repairapply apply ON repair.repairapply_id = apply.id
     JOIN equipmgr_devicefaultdata fault ON apply.fault_id = fault.id
     JOIN equipmgr_organization fromorg ON apply.fromcompany_id = fromorg.id
     JOIN equipmgr_repairer repairorg ON apply.repaircompany_id = repairorg.id;
