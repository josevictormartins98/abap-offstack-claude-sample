# Project: [Your SAP Module / Application Name]

## System Landscape

- DEV: [SID] – development system
- QAS: [SID] – quality assurance
- PRD: [SID] – production
- SAP Basis version: [e.g., 7.57, S/4HANA 2023]
- ABAP language version: [Standard ABAP / ABAP for Cloud Development]

## Naming Conventions

- Custom classes: ZCL_ prefix (e.g., ZCL_MM_PURCHASE_ORDER)
- Custom interfaces: ZIF_ prefix (e.g., ZIF_MM_PO_VALIDATOR)
- Custom RAP objects: ZR_ for root views, ZC_ for consumption views
- Function modules: Z_FM_ prefix
- Programs: Z_RPT_ prefix for reports
- Package structure: Z[MODULE]_[AREA] (e.g., ZMM_PURCHASING)

## Transport Rules

- Transport layer: Z[MODULE] – routes DEV -> QAS -> PRD
- All objects must be assigned to a transport before modification
- Release approval: required from [role] before QAS import

## Patterns to Avoid

- SELECT - – always specify field list
- MOVE-CORRESPONDING without explicit mapping review
- Old FM signatures (e.g., POPUP_TO_CONFIRM_STEP -> use POPUP_TO_CONFIRM)
- CATCH SYSTEM-EXCEPTIONS – use TRY/CATCH with class-based exceptions
- Inline WRITE statements in classes – use application Log instead

## Error Handling

- Use RAISE EXCEPTION TYPE [zcx_custom_exception]
- Log via BAL_LOG_CREATE -> BAL_LOG_MSG_ADD -> BAL_DB_SAVE
- MESSAGE ... RAISING pattern for function modules

## Testing

- ABAP Unit mandatory for all new classes
- Use CL_ABAP_TESTDOUBLE for test doubles
- Test classes: FOR TESTING, RISK LEVEL HARMLESS