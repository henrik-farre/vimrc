------------------------------------------------------------
-- Output selected yaml schema from yaml-companion
--
function get_yaml_schema()
  local schema = require("yaml-companion").get_buf_schema(0)
  if schema then
    return schema.result[1].name
  end
  return ""
end
