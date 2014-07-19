# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Car.create([
               { :name => '科迈罗', :price => '455,800', :en => 'CAMARO', :image => 'http://www.chevrolet.com.cn/brandsite/userfiles/car/99f06d88d7ba48e6b098c3861f271bdb.png' },
               { :name => '科帕奇', :price => '219,800', :en => 'CAPTIVA', :image => 'http://www.chevrolet.com.cn/brandsite/userfiles/car/78e26ad4972f4fa9bfbbd823aacb1bca.png' },
               { :name => '迈锐宝', :price => '169,900', :en => 'MALIBU', :image => 'http://www.chevrolet.com.cn/brandsite/userfiles/car/4cfb8f459f9645dc932075dcd5273bd4.png' },
               { :name => '创酷', :price => '119,900', :en => 'TRAX', :image => 'http://www.chevrolet.com.cn/brandsite/userfiles/car/eef0c29a784c49b5bddaff4b211219ed.png' },
               { :name => '景程', :price => '108,900', :en => 'EPICA', :image => 'http://www.chevrolet.com.cn/brandsite/userfiles/car/6969b0d07dd048dbb67c4f40aa4ef294.png' },
               { :name => '科鲁兹', :price => '108,900', :en => 'CRUZE', :image => 'http://www.chevrolet.com.cn/brandsite/userfiles/car/fbedc4bcba3042eea065c33e9f72c564.png' },
               { :name => '爱唯欧', :price => '73,900', :en => 'AVEO', :image => 'http://www.chevrolet.com.cn/brandsite/userfiles/car/c54d5012e4c4485483379f9c31f91ecf.png' },
               { :name => '新赛欧', :price => '56,800', :en => 'SAIL', :image => 'http://www.chevrolet.com.cn/brandsite/userfiles/car/525d085f11684c1497b4647e9e4bb374.png' },
           ])