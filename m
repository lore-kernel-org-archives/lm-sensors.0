From: barrow_dj@yahoo.com (D.J. Barrow)
Date: Fri, 27 Oct 2006 12:20:49 +0000
Subject: [lm-sensors] helpful list of starting points on getting lmsensors
Message-Id: <20061027122050.39829.qmail@web51106.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Collected by a colleague of mine at work.
may be useful in constructing a readme.

/home/mmm/help/snmp

#--ucdsnmp now known as net-snmp (5.)
http://www.net-snmp.org/

~ $ snmpwalk -Cc vlan1 public
system.sysDescr.0 =3D 5.1.4.70.R03 Service Release, February 16, 2004.
system.sysObjectID.0 =3D OID: enterprises.6486.800.1.1.2.1.1.1.1
system.sysUpTime.0 =3D Timeticks: (370339500) 42 days, 20:43:15.00
system.sysContact.0 =3D Alcatel Internetworking, www.ind.alcatel.com
system.sysName.0 =3D OMNI7700-THALES
system.sysLocation.0 =3D THALES-COMPUTERS-Toulon
system.sysServices.0 =3D 72
interfaces.ifNumber.0 =3D 76
interfaces.ifTable.ifEntry.ifIndex.1001 =3D 1001
interfaces.ifTable.ifEntry.ifIndex.1002 =3D 1002
...
takes several minutes. See snmpcmd(1) for all options.

can also walk cetia:
 snmpwalk -Cc cetia public

snmpwalk localhost public
snmpget
 Scalars must have oid ending 0.

#--commands
http://www.net-snmp.org/tutorial/tutorial-5/commands/index.html
   1. snmptranslate: learning about the MIB tree.
   2. snmpget: retrieving data from a host.
   3. snmpgetnext: retrieving unknown indexed data.
   4. snmpwalk: retrieving lots of data at once!
   5. snmptable: displaying table.
   6. snmpset: peforming write operations.
   7. snmptrap: Sending and receiving traps, and acting upon them.
         1. Sending and receiving SNMPv3 TRAPs and INFORMs
   8. Common command options:
         1. Using and loading MIBS
         2. SNMPv3 Options
         3. Customized Output Formats


#--snmpd
demon agent. gathers data locally, replies to requests for data.

#--snmptrapd
demon listens for incoming traps. logs its, sends email, runs script.

#--example code
http://www.net-snmp.org/tutorial/tutorial-5/toolkit/index.html

# Programming a simple application.
# Programming a asynchronous application.
# How to program a mib module to serve information described by an SNMP
  MIB, and how to compile it into the net-snmp snmpd agent.=20
# Compiling a mib module to be used as a dynamically loaded shared object.
# Writing a subagent program to attach to the master SNMP agent.
# Extend the agent using perl and the NetSNMP::agent perl module.
# Letting mib2c generate code for you.

#--snmp traps perl munger
http://www.snmptt.org/docs/snmptt.shtml
SNMP Trap Translator, eg run a script when a trap received by snmptrapd.

#--suse 9
/etc/init.d/snmpd start

#--mrtg
http://www.net-snmp.org/tutorial/tutorial-5/mrtg/index.html
mrtg is useful cos it provides an snmpd.conf to monitor system info and
network use, disk space, free memory,=20
eg User vs Idle CPU usage

#--simple application
http://www.net-snmp.org/tutorial/tutorial-5/toolkit/index.html
~/snmp/tutorial/

 to get a var from a host
snmpdemoapp.c: uses v3 authentication. see DEMO_USE_SNMP_VERSION_3
link with -lsnmp

 #include <net-snmp/net-snmp-config.h>
 #include <net-snmp/net-snmp-includes.h>
 init_snmp("myapp");
 struct snmp_session session: address of remote
 snmp_sess_init(&session);
 session.peername =3D strdup("remote hostname");
 session.version =3D SNMP_VERSION_1;
 session.community =3D "public";
 session.community_len =3D strlen(session.community);
 struct snmp_session *ss;
 ss =3D snmp_open(&session); // socket. if(ss=3D0) ok
 struct snmp_pdu pdu;
 pdu =3D snmp_pdu_create(SNMP_MSG_GET); // empty packet
 oid anOID[MAX_OID_LEN]; size_t anOID_len =3D MAX_OID_LEN;
 // eg get system.sysDescr.0: one of these 3:
    read_objid(".1.3.6.1.2.1.1.1.0", anOID, &anOID_len);
    get_node("sysDescr.0", anOID, &anOID_len);
    read_objid("system.sysDescr.0", anOID, &anOID_len);
 // as its a get, need to pair null value to oid
 snmp_add_null_var(pdu, anOID, anOID_len); // copy to pdu
 struct snmp_pdu *response;
 status =3D snmp_synch_response(ss, pdu, &response); // send it. wait reply
 if (status =3D STAT_SUCCESS)
   if(response->errstat =3D SNMP_ERR_NOERROR)  // ok
   else   snmp_errstring(response->errstat))
 else snmp_sess_perror("snmpget", ss);
 if ok
  struct variable_list *vars;
  for(vars =3D response->variables; vars; vars =3D vars->next_variable)
        print_variable(vars->name, vars->name_length, vars);
	if (vars->type =3D ASN_OCTET_STR)
	  char *sp =3D malloc(1 + vars->val_len);
	  memcpy(sp, vars->val.string, vars->val_len);
	  sp[vars->val_len] =3D '\0';
  snmp_free_pdu(response); snmp_close(ss);=20

#--writing a MIB
http://www.simpleweb.org/ietf/rfcs/rfcbytopic.html

 Structure of Management Information Version 2 (SMIv2)
  http://tools.ietf.org/html/rfc2578

 Textual Conventions for .. SNMPv2
  rfc1903.txt

 Concise MIB definitions
  http://www.simpleweb.org/ietf/rfcs/complete/rfc1212.txt
 Structure and Identification of Management Information for TCP/IP-based ..
  http://www.simpleweb.org/ietf/rfcs/complete/rfc1155.txt
=20
 ASN.1
  http://en.wikipedia.org/wiki/Abstract_syntax_notation
  http://www.columbia.edu/~ariel/ssleay/layman.html

Not all basic types of ASN.1 are allowed in MIBs. Principally
INTEGER,OBJECT IDENTIFIER,OCTET STRING,
built up with SEQUENCE and SEQUENCE OF.
In particular, no floating point!
Whitespace ignored. -- comment until -- or eol.
"string of ascii only" can have \n\r.
'01010000'b binary (multiple of 8)
'ffaabb00'h hex (multiple of 2)


Objects are in groups. The whole of a group must be implemented.
If an object class can have multiple instances, need to declare a table.
Each column is a class attribute. Use <~20 columns so can fit in a pdu.


macro call:
  <descriptor> <macro> <clauses> ::=3D <value>
where descriptor starts lowercase, best <32chars, no -.

partial entry:
 mynameforobject OBJECT-TYPE
       SYNTAX     INTEGER
       UNITS      "RMS Volts"
       MAX-ACCESS read-write
       STATUS     current	<-- as opposed to obsolete, deprecated
       DESCRIPTION  "blah blah"
       ::=3D { parentname 1 }     <-- oid, parent plus new subindex 1, 2,...

if an entry is like an enum, list the possible values, 0 is not allowed!
       SYNTAX     INTEGER { disabled(1), enabled(2), muted(3) }
       SYNTAX     INTEGER (1..2147483647)

can add info on how to print, if integer value:
       DISPLAY-HINT "d"
format is either "x" "o" "b" for hex octal binary, or "d-<shift>" where
shift is number of decimal places to shift, eg d-3 =3D> 1234 prints as 1.234
For OCTET STRING, format is <repeat><bytes>{xdoa}[<char>]<fillchar>

For a string value, of some max len 32 say:
       SYNTAX  DisplayString (SIZE (0..31))  <--ascii
       SYNTAX  OCTET STRING (SIZE(12))   <--binary data
       SYNTAX  BITS ?
       SYNTAX  TimeTicks	<--time in secs*100 since some epoch
       SYNTAX  Gauge		<--non-negative with some fixed max
       SYNTAX  NetworkAddress	<--IP
       SYNTAX  PhysAddress	<--mac
       SYNTAX  Counter		<--non-negative monotonic increasing with wrap
       SYNTAX  Counter64	<--64 bits
       SYNTAX  OBJECT IDENTIFIER <--an oid?

lists:
	SYNTAX SEQUENCE { <type1>, ..., <typeN> }
tables:
	SYNTAX SEQUENCE OF <entry>

rfc1903 talks of TEXTUAL-CONVENTION macro to allow you to create new type
of thing that says how to display it too. Eg DateAndTime,  TruthValue.

 Hundredths ::=3D TEXTUAL-CONVENTION
         DISPLAY-HINT "d-2"
         SYNTAX INTEGER (0..10000)

start with example rfc1628    UPS-MIB
wget http://www.ietf.org/rfc/rfc1628.txt
run smistrip on it
or look for mibs on http://www.simpleweb.org/ietf/mibs/
 http://www.mibsearch.com/
 (pay: http://www.mibdepot.com/index.shtml)

see my /home/mmm/snmp/RACK-MIB.txt based on UPS-MIB

Add your mib to snmp.conf
 mibs +MY-MIB
Put your mib in the search path: $HOME/.snmp/mibs /usr/share/snmp/mibs
Check you can find your oid fieldname
 snmptranslate -IR MyVoltage
(for testing can use "-m +MY-MIB" cmd args, or export MIBS=3D+MY-MIB,
and set MIBDIRS search path)


#--mib2c: MFD: MIBs For Dummies
converts a mib description to prototype C files to implement an agent.
~/snmp/tutorial/
http://www.net-snmp.org/tutorial/tutorial-5/toolkit/mfd/if-mib/ifTable/inde=
x.html
tutorial using predefined ifTable oid.
mib2c-update can update your app when you change your mib later.

You need to
. write a mib
. generate code with mib2c on toplevel node
. Implement a netsnmp_container for data access
. Implement GET request functions
. Implement SET request functions
You can run your agent as a subagent of main snmp (using AgentX),
or compile as dynamic loadable module, or compile with main snmp src.

mib2c -c CONFIGFILE [-I PATH] [-f OUTNAME] [-i][q][-S VAR=3DVAL] MIBNODE
using a configfile:
  mib2c.scalar.conf		<-your fn called for each get
  mib2c.int_watch.conf		<-tie vars to scalars, no sideeffect
  mib2c.iterate.conf            <-table
  mib2c.create-dataset.conf	<-table no side effect to set
  mib2c.array-user.conf		<-table index direct to data, but sideeffect
  mib2c.column_defines.conf	<-generate defines for columns
  mib2c.column_enums.conf

Software generated for agent has 4 contexts or structs:
 User Context. your handle=20
 MIB context. hold mib index for row
 Data Context. data needed to get/set a value.
 Row Request Context. groups the other 3.

 netsnmp_container interfaces to your data store.
  either: first request for table calls cache_load(netsnmp_container)
           later requests use cached values for a time
  or: any request, calls get_next() repeatedly loops over all items.
  or: you wrap a netsnmp_container around your existing data fetch

 full snmp agent api:
  http://www.net-snmp.org/dev/agent/group__handler.html

On qemu, need to install
 gw1:/data/RPMS-RHEL4-U3/RedHat/RPMS/net-snmp-perl-5.1.2-11.EL4.6.i386.rpm

#++++ --example agent with no side effect. get/set integer var--
http://www.net-snmp.org/dev/agent/scalar__int_8c-example.html

file: myscalar_int.c
#include <net-snmp/net-snmp-config.h>
#include <net-snmp/net-snmp-includes.h>
#include <net-snmp/agent/net-snmp-agent-includes.h>
static int      example1 =3D 42;  /* default value */
void init_myscalar_int(void){ // function name must match init_FILENAME() !!
    oid my_registration_oid[] =3D { 1, 3, 6, 1, 4, 1, 8072, 2, 1, 1, 0 };
    netsnmp_register_int_instance("my example int variable",
                                  my_registration_oid,
                                  OID_LENGTH(my_registration_oid),
                                  &example1, NULL);
}

#--
http://www.nagiosexchange.org/Demosites.138.0.html?&tx_netnagext_pi1%5Bowne=
r%5D=3DJdYidMBHR1QW3MIdPHvnyrSDzMJpq9fPSYzU5UfpU3Q%3D

#--
http://www.net-snmp.org/tutorial/tutorial-5/index.html
http://www.net-snmp.org/docs/FAQ.html

#--monitor apache internals
http://freshmeat.net/projects/mod-apache-snmp/

#--perl
http://snmp-info.sourceforge.net/
SNMP::Info gives an object oriented interface to information obtained
through SNMP

#--
http://freshmeat.net/projects/braa/
Braa is a tool for making SNMP queries.

http://sourceforge.net/projects/snarl-snmp

#--standard mibs http://www.ietf.org/rfc/rfc2737.txt
IF-MIB 2233 The Interfaces Group MIB using SMIv2
Entity MIB rfc2737 for many of a kind?
MIBII 1213 for Network Management of TCP/IP-based internets
EtherLike-MIB 2665
IGMP-MIB 2993 Architectural Implications of NAT
RMON-MIB 1757 Remote Network Monitoring

#--example MIBs listed by cisco for a product:
Standard MIBs
? IF-MIB (RFC-2233)
? ENTITY-MIB (RFC-2737)
? MIBII (RFC1213)
? EtherLike-MIB (RFC-2665)
? IGMP-MIB (RFC-2993)
? RMON-MIB (RFC-1757)
Expression MIBs SNMPv2-SMI
? SNMPv2-TC
? SNMPv2-MIB
? IANAifType-MIB
Simple Network Management Protocol (SNMP) v3 MIBs
? SNMP-FRAMEWORK-MIB (RFC-2571)
? SNMP-MPD-MIB (RFC-2572)
? SNMP-NOTIFICATION-MIB (RFC-2573)
? SNMP-TARGET-MIB (RFC-2573)
? SNMP-USM-MIB (RFC-2574)
? SNMP-VACM-MIB (RFC-2575)
DOCSIS? and EuroDOCSIS MIB
? DOCS-IF-MIB (v2 Rev04)
? DOCS-CABLE-DEVICE-MIB (RFC-2669)
? DOCS-BPI-PLUS-MIB (Rev 5)
? DOCS-QOS-MIB (Rev 4)
? DOCS-CABLE-DEVICE-TRAP-MIB
? DOCS-SUBMGT-MIB (Rev 2)
Cisco DOCSIS MIBs
? CISCO-CABLE-WIDEBAND-MIB
? CISCO-DOCS-EXT-MIB
? CISCO-DOCS-REMOTE-QUERY-MIB
? CISCO-DOCS-QOS-EXT-MIB
? CISCO-CABLE-SPECTRUM-MIB
? CISCO-CABLE-AVAILABILITY-MIB
? CISCO-DOCS-EXT-CAPABILITY-MIB
Cisco Generic MIBs
? CISCO-SYSLOG-MIB
? CISCO-SMI-MIB
? CISCO-TC-MIB
? CISCO-PRODUCTS-MIB
? CISCO-FLASH-MIB
? CISCO-CONFIG-MAN-MIB
? CISCO-CONFIG-COPY-MIB
? CISCO-MEMORY-POOL-MIB
? CISCO-BULK-FILE-MIB
? CISCO-SONET-MIB
? CISCO-TCP-MIB
? CISCO-RTTMON-MIB
? CISCO-FTP-CLENT-MIB
? CISCO-IPMROUTE-MIB
? CISCO-QUEUE-MIB
? CISCO-IMAGE-MIB
? CISCO-ENVMON-MIB
? CISCO-ENTITY-VENDORTYPE-OID-MIB
? CISCO-PRODUCTS-MIB

#--pmp6=20
rpm -qi net-snmp
Version     : 5.1.2=20

/usr/share/snmp/mibs/UCD-SNMP-MIB.txt
/usr/share/snmp/mibs/SNMP-COMMUNITY-MIB.txt
/usr/share/snmp/mibs/IP-MIB.txt
/usr/share/snmp/mibs/NET-SNMP-AGENT-MIB.txt
/usr/share/snmp/mibs/SNMP-USER-BASED-SM-MIB.txt
/usr/share/snmp/mibs/HOST-RESOURCES-TYPES.txt
/usr/share/snmp/mibs/DISMAN-SCRIPT-MIB.txt
/usr/share/snmp/mibs/IANA-ADDRESS-FAMILY-NUMBERS-MIB.txt
/usr/share/snmp/mibs/SNMP-TARGET-MIB.txt
/usr/share/snmp/mibs/IPV6-UDP-MIB.txt
/usr/share/snmp/mibs/HCNUM-TC.txt
/usr/share/snmp/mibs/SNMPv2-TM.txt
/usr/share/snmp/mibs/LM-SENSORS-MIB.txt
/usr/share/snmp/mibs/IPV6-TCP-MIB.txt
/usr/share/snmp/mibs/IPV6-MIB.txt
/usr/share/snmp/mibs/SNMP-FRAMEWORK-MIB.txt
/usr/share/snmp/mibs/DISMAN-SCHEDULE-MIB.txt
/usr/share/snmp/mibs/IP-FORWARD-MIB.txt
/usr/share/snmp/mibs/RMON-MIB.txt
/usr/share/snmp/mibs/IANAifType-MIB.txt
/usr/share/snmp/mibs/INET-ADDRESS-MIB.txt
/usr/share/snmp/mibs/SNMPv2-TC.txt
/usr/share/snmp/mibs/RFC-1215.txt
/usr/share/snmp/mibs/SNMP-PROXY-MIB.txt
/usr/share/snmp/mibs/IF-INVERTED-STACK-MIB.txt
/usr/share/snmp/mibs/NET-SNMP-TC.txt
/usr/share/snmp/mibs/SMUX-MIB.txt
/usr/share/snmp/mibs/SNMPv2-CONF.txt
/usr/share/snmp/mibs/UDP-MIB.txt
/usr/share/snmp/mibs/NOTIFICATION-LOG-MIB.txt
/usr/share/snmp/mibs/RFC1155-SMI.txt
/usr/share/snmp/mibs/IPV6-ICMP-MIB.txt
/usr/share/snmp/mibs/UCD-IPFWACC-MIB.txt
/usr/share/snmp/mibs/IF-MIB.txt
/usr/share/snmp/mibs/IPV6-TC.txt
/usr/share/snmp/mibs/SNMP-NOTIFICATION-MIB.txt
/usr/share/snmp/mibs/SNMP-USM-AES-MIB.txt
/usr/share/snmp/mibs/NET-SNMP-MIB.txt
/usr/share/snmp/mibs/HOST-RESOURCES-MIB.txt
/usr/share/snmp/mibs/UCD-DEMO-MIB.txt
/usr/share/snmp/mibs/NET-SNMP-EXAMPLES-MIB.txt
/usr/share/snmp/mibs/TCP-MIB.txt
/usr/share/snmp/mibs/SNMPv2-MIB.txt
/usr/share/snmp/mibs/IANA-LANGUAGE-MIB.txt
/usr/share/snmp/mibs/AGENTX-MIB.txt
/usr/share/snmp/mibs/EtherLike-MIB.txt
/usr/share/snmp/mibs/UCD-DLMOD-MIB.txt
/usr/share/snmp/mibs/SNMP-MPD-MIB.txt
/usr/share/snmp/mibs/UCD-DISKIO-MIB.txt
/usr/share/snmp/mibs/SNMP-VIEW-BASED-ACM-MIB.txt
/usr/share/snmp/mibs/SNMPv2-SMI.txt
/usr/share/snmp/mibs/RFC1213-MIB.txt


grep -i temperature /usr/share/snmp/mibs/*
/usr/share/snmp/mibs/LM-SENSORS-MIB.txt

# vva has changed=20
PMP6/pmp-base-config/pmp-base-config/usr/share/powermp/etc/snmp/snmpd.conf
so community "public" is read-only?
added systemview.

#diff -U1 /var/pmp-backup/snmpd.conf.20060719-083424 /etc/snmp/snmpd.conf
+# laTable
+view   systemview    included   .1.3.6.1.4.1.2021.10
+# systemStats
+view   systemview    included   .1.3.6.1.4.1.2021.11
-syslocation Unknown (edit /etc/snmp/snmpd.conf)
-syscontact Root <root at localhost> (configure /etc/snmp/snmp.local.conf)
+syslocation PowerMP Rack
+syscontact Root <root at powermp>=20
=20

# ls -l /etc/snmp/snmpd.conf /var/net-snmp/snmpd.conf /var/pmp-backup/snmpd=
.conf.20060719-083424
/usr/share/powermp/etc/snmp/snmpd.conf
-rw-r--r--  1 root root 18646 Jul 19 08:34 /etc/snmp/snmpd.conf
-rw-r--r--  1 root root 18646 Jul  5 15:30 /usr/share/powermp/etc/snmp/snmp=
d.conf
 got copied to above.=20

-rw-r--r--  1 root root 18579 Jul 19 08:34 /var/pmp-backup/snmpd.conf.20060=
719-083424
-rw-------  1 root root   661 Aug 16 18:05 /var/net-snmp/snmpd.conf
 created by demon. ignore.

#--man snmpd.conf
EXTENSIBLE-MIB
 Net-SNMP agent reports via queries to the 1.3.6.1.4.1.2021 section of the =
MIB.
 All below this OID has structure:
 .1 -- index. table's index numbers for each of the DIRECTIVES below.
 .2 -- name. name of given entry.  ought to be unique
 .100 -- errorFlag. int 1 if entry in error
 .101 -- errorMsg. DISPLAY-STRING describing error if 1.
 .102 -- errorFix. if 1 and errorFlag=3D1 exec the program named in config.h
 DIRECTIVES
  proc NAME [MAX [MIN]]
   if ps -e dont show process NAME, then set .100=3D1 and set .101
  procfix NAME PROG ARGS
   run this command when .101:=3D1
  exec [MIBNUM] NAME PROG ARGS
   run this command and .100:=3Dexitcode .101=3Dfirst-line-of-stdout.
   if MIBNUM (numeric) given, MIBNUM.100.0:=3Dexitcode and
     MIBNUM.101.1=3Dstdout-line-1
     MIBNUM.101.2=3Dstdout-line-2 etc
  execfix NAME PROG ARGS
   run when .102:=3D1
  disk PATH [MINSPACE|MINPERCENT%]
   if diskspace<min(kb) or min%(%) .100:=3D1 and .101:=3Dmsg
  includeAllDisks MINPERCENT%
  load MAX1 [MAX5 [MAX15]]
   load average 1 5 15 minutes average>max set .100:=3D1 etc
  file FILE [MAXSIZE]
   kbytes. 20 files can be monitored.
 global errors are in .101.1.100 .101.

SUB-AGENTS
 AGENTX
  master agentx
  AgentXSocket addr
   listen address. default /var/agentx/master. eg localhost:705
  AgentXTimeout timeout. default  1 second
  AgentXRetries retries. default 5
 SMUX

DYNAMICALLY LOADABLE MODULES
 dlmod NAME FILENAME
  expects to find in abs file FILENAME a routine init_NAME
  compile FILENAME as .so -fPIC -shared
  for debug try launch: snmpd -f -L -Ddlmod,<NAME>


ACCESS CONTROL
 rouser USER [noauth|auth|priv [OID]]
 rwuser ditto
  wrappers for group, access, and view  directives
 rocommunity COMMUNITY [SOURCE [OID]]
 rwcommunity ditto
  wrappers for com2sec,  group,  access,  and  view

 com2sec NAME SOURCE COMMUNITY
  source/community to security name mapping. first matching entry used.
  SOURCE:  hostname, subnet (IP/MASK or IP/BITS),  "default"
 group NAME MODEL SECURITY
  securitymodel/securityname to group map.
  MODEL: v1, v2c, usm
 access NAME CONTEXT MODEL LEVEL PREFX READ WRITE NOTIFY
  map group/security model/security level to a view.
  MODEL: any, v1, v2c, usm
  LEVEL: noauth, auth, priv
  PREFX: exact  or prefix. match of CONTEXT against incoming pdu
  READ, WRITE and NOTIFY are views
 view NAME TYPE SUBTREE [MASK]
  define a view. can repeat on same name.
  TYPE included, excluded
  MASK hexoctet.hexoctet... or hexoctet:hexoctet:...
   bitmask to apply bit by bit from left to each oid number (eg ... .1 80)

 IPv6 version: com2sec6 rocommunity6 rwcommunity6

  example: from localhost only, rw all, community name: powermp
    com2sec mylocal localhost powermp
    group myrwgroup any mylocal
    view all included .1 80
    access myrwgroup "" any noauth 0 mylocal mylocal mylocal

  example: readonly community: public
    com2sec notConfigUser default public
    group notConfigGroup v1 notConfigUser
    group notConfigGroup v2c notConfigUser
    view systemview included .1.3.6.1.2.1.1
    view systemview included .1.3.6.1.2.1.25.1.1
    access MyRWGroup "" any noauth 0 all all all


DISMAN-EVENT-MIB
for sending traps on errors. buggy. generated once ("edge not level").
 agentSecName NAME
  a rouser name to be used for scanning for trap event.
 monitor [OPTIONS] NAME EXPRESSION
  monitor yourself.
   EXPRESSION: oid !=3D, =3D, <, <=3D, >, >=3D integer
      for -t?: oid low high
   NAME your arbitrary name
   -t: threshold ie trap if value>high or value<low.
   -r FREQUENCY: each F seconds. default 600
   -u SECNAME: a rouser name to be used for scanning for trap event.
   -o OID: include this value in trap call
   -e EVENTNAME: name of notificationEvent
 notificationEvent NAME NOTIFICATIONOID [[-w] OID_OBJECT ...]
  event to attach to a monitor -e NAME.

 example:
  rouser me
  monitor -u me -o sysUpTime.0 -o hrSWRunName "biggie" hrSWRunPerfMem > 100=
00
   check hrSWRunPerfTable of running processes and send out trap for any
   using over 10M of memory.
   snmptrapd would produce eg:
    2002-04-05 13:33:53 localhost.localdomain [udp:127.0.0.1:32931]:sysUpTi=
meInstance =3D Timeticks:
(1629) 0:00:16.29 snmpTrapOID.0 =3D OID: mteTriggerFired    mteHotTrigger =
=3D biggie mteHotTargetName
=3D      mteHotContextName =3D     mteHotOID =3D OID: hrSWRunPer fMem.1968 =
   mteHotValue =3D 28564   =20
hrSWRunName.1968 =3D "xemacs"


=20
SETTING SYSTEM INFORMATION
 syslocation STRING
 syscontact STRING
 sysname STRING
  these objects usually rw. setting them makes them ro.

PASS-THROUGH CONTROL
 pass MIBOID EXEC

#--man snmp.conf
/etc/snmp/snmp.conf -- not found on pmp6
 mibdirs [+]mib-dir:...
  replace or add to PATH to look for mibs
 mibs [+]mib-token:...  or ALL
 mibfile file

#--snmpd
 -c configfile
 -C no default config
 -d dump hex packets
 -Dtoken debug print for token. -D for all.
 -V Symbolically dump SNMP transactions
 -f dont fork
 -g gid run as group
 -u uid
 -Lf<file> log to file
 -r dont need to be root
 -X run as AgentX subagent
 [udp|tcp:]hostname[:port] listen here instead of udp:161
 [unix:]pathname

#---/usr/share/snmp/mibs/

=20
#--man snmptrapd
 receives and logs SNMP TRAPs

#--snmpwalk
If you are unsure of the correct row number within a specific table,

 snmpwalk -v 2c -c public -m ALL localhost prNames
  -m MIBLIST
  -c community
  -v 1 | 2c | 3
  -d     Dump packets

#--dump configured mibs. doesnt query snmp, just reads config files
snmptranslate oid
 -Td   Print full details of the specified OID.
 -Tp   Print a graphical tree, rooted at the specified OID.
 -Ta   Dump the loaded MIB in a trivial form.
 -Tl   Dump a labeled form of all objects.
 -To   Dump a numeric form of all objects.
 -Ts   Dump a symbolic form of all objects.
 -Tt   Dump a tree form of the loaded MIBs (mostly  useful  for
 -On   print numeric oid
 -IR  =20

snmptranslate -Tl | pg
#
.iso(1).org(3).dod(6).internet(1).private(4).enterprises(1).ucdavis(2021).u=
cdExperimental(13).lmSensors(16).lmSensorsMIB(1)
snmptranslate -Tos
#.1.3.6.1.4.1.2021.13.16
#.iso.org.dod.internet.private.enterprises.ucdavis.ucdExperimental.lmSensors


#---------------------------------------------------------------------
#--play. try get sensors to be read
# need to scan and init sensors:
sensors-detect # perl script, writes file: /etc/sysconfig/lm_sensors
# on pentxm(-1) get in this file (plus comments)
cat >>/etc/sysconfig/lm_sensors <<\!
# Generated by sensors-detect on Thu Aug 17 16:22:48 2006
MODULE_0=3Di2c-i801
MODULE_1=ADm1021
!

# seems to be running by default:
chkconfig --list lm_sensors
lm_sensors      0:off   1:off   2:on    3:on    4:on    5:on    6:off

$ sensors
max1617-i2c-0-29
Adapter: SMBus I801 adapter at 1880
Board:       +34?C  (low  =3D   -55?C, high =3D  +127?C) =20
CPU:         +30?C  (low  =3D   -55?C, high =3D  +127?C) =20


# need to permit access to default view else get:
#  LM-SENSORS-MIB::lmSensors =3D No more variables left in this MIB View...
# lmSensors is .1.3.6.1.4.1.2021.13.16
echo 'view systemview included .1.3.6.1.4.1.2021.13' >mysnmpd.conf
snmpd -f -r -D -V -c mysnmpd.conf udp:16000 >log 2>&1 &
tail -f log &
# snmpwalk -d -v 2c -c public -m ALL udp:16000 lmSensors=20
snmpwalk -v 2c -c public -m ALL udp:16000 lmSensors=20
node1:~ $ snmpwalk -v 2c -c public -m ALL udp:16000 lmSensors=20
LM-SENSORS-MIB::lmMiscSensorsIndex.1 =3D INTEGER: 0
LM-SENSORS-MIB::lmMiscSensorsIndex.2 =3D INTEGER: 1
LM-SENSORS-MIB::lmMiscSensorsIndex.3 =3D INTEGER: 2
LM-SENSORS-MIB::lmMiscSensorsDevice.1 =3D STRING: Board
LM-SENSORS-MIB::lmMiscSensorsDevice.2 =3D STRING: CPU
LM-SENSORS-MIB::lmMiscSensorsDevice.3 =3D STRING: alarms
LM-SENSORS-MIB::lmMiscSensorsValue.1 =3D Gauge32: 34000
LM-SENSORS-MIB::lmMiscSensorsValue.2 =3D Gauge32: 31000
LM-SENSORS-MIB::lmMiscSensorsValue.3 =3D Gauge32: 128000
LM-SENSORS-MIB::lmSensors =3D No more variables left in this MIB View (It i=
s past the end of the MIB
tree)


# load some library. dont need for lmsensors, compiled in
if false
then	echo dlmod sensors /usr/lib/libsensors.so.3 >~/snmpd.conf
	snmpd -c ~/snmpd.conf -f -r -D -V udp:16000 >log 2>&1 &
	# dlmod: dlmod_load_module sensors: /usr/lib/libsensors.so.3
	# dlsym failed: can't find 'init_sensors'
else	ldd /usr/sbin/snmpd|grep sensors
	# libsensors.so.3 =3D> /usr/lib/libsensors.so.3 (0x00111000)
fi

# list compiled in options and mibs
snmpd -Dmib_init -H 2>&1 | pg
# mib_init: initializing: lmSensors

#--enterprise private numbers
http://dragon/phpwiki/index.php/SNMP
http://www.iana.org/assignments/enterprise-numbers (2Mbytes)
ask for new id:
 http://www.iana.org/cgi-bin/enterprise.pl

20885
  Thales Computers
    Gerard Cristau
      gcr at thalescomputers.fr



D.J. Barrow Linux kernel developer
email: dj_barrow at ariasoft.ie
email(work) denis.barrow at thalescomputers.fr
Work: +33-498-163412
Home: +353-22-47196.
Mobile (IRL) +353-(0)86 1715438

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20

