#!/bin/bash
/usr/local/bin/dlanlist eth0 | /usr/bin/awk '\
/local|remote/{\
  dlan_info[i++] = "dlan_info{macaddress=\"" $2 "\",type=\"" $1 "\",version=\"" substr($0,45) "\"} 1";\
}\
/remote/{\
  dlan_rx[r++] = "dlan_rx{macaddress=\"" $2 "\"} " $5;\
  dlan_tx[t++] = "dlan_tx{macaddress=\"" $2 "\"} " $3;\
}\
END{\
  print "# HELP dlan_info MAC address, software version and indicator for local/remote";\
  print "# TYPE dlan_info gauge";\
  for (i in dlan_info)\
    print dlan_info[i];\
  print "# HELP dlan_rx Receive pyhsical sync in Mbit/s";\
  print "# TYPE dlan_rx gauge";\
  for (i in dlan_rx)\
    print dlan_rx[i];\
  print "# HELP dlan_tx Transmit physical sync in MBit/s";\
  print "# TYPE dlan_tx gauge";\
  for (i in dlan_tx)\
    print dlan_tx[i];\
}'
