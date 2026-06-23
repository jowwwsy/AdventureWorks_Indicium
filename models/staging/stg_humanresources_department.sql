with transformed as (
SELECT
    CAST(departmentid AS INT) AS department_id,
    name as department_nm,
    groupname as group_nm,
    date(modifieddate) as modified_at
FROM {{ source('adventure_works', 'humanresources_department') }}
)

SELECT * from transformed