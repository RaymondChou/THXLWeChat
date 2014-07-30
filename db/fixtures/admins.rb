# 管理员初始账号
Admin.seed do |s|
  s.id    = 1
  s.admin_name = "thxl"
  s.admin_full_name = "天泓雪莱"
  s.password  = "thxl123456"
  s.created_at = Time.now
  s.updated_at = Time.now
end