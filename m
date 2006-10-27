From: barrow_dj@yahoo.com (D.J. Barrow)
Date: Fri, 27 Oct 2006 11:26:59 +0000
Subject: [lm-sensors] getting lmsensors working with snmp
Message-Id: <20061027112659.63479.qmail@web51107.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
There is no documentation in the source code
about getting lm_sensors working with SNMP
or anywhere on the lmsensors website.
why is it a black art & not documented anywhere?
This is a serious ommission, surely SNMP monitoring
is important to your project.


The first link I can find which gives any real info on
SNMP with lmsensors is

http://people.redhat.com/harald/snmp-lmsensors/HOWTO-SENSORS-SNMPD.html

& this document is dated from 2000.

The following more recent link has some info on snmp with lmsensors
with pretty gui pictures included
http://forums.cacti.net/viewtopic.php?t590
But there is no info whatsoever on the lmsensors website
about getting snmp going.

A colleague at work did the following,
I believe his instructions are incomplete
as I can't see how the snmp agent is
registered at the .1.3.6.1.4.1.2021.13.16 OID address
>
> /etc/snmp/snmpd.conf
>
>a line like
>
> # lmSensors
> view	systemview    included   .1.3.6.1.4.1.2021.13.16
>
>and restart snmpd to allow you access to this oid from the localhost.
> 
> $ snmpwalk -v 2c -c public -m ALL localhost lmSensors
>
>should then start saying something.  My example above had udp:16000 instead of
>localhost as I had started a 2nd sndmp server on another port to test with.


Any help would be greatly appreciated
& whoever does your documentation should document this stuff.

Thanks,
D.J. Barrow


D.J. Barrow Linux kernel developer
email: dj_barrow at ariasoft.ie
email(work) denis.barrow at thalescomputers.fr
Work: +33-498-163412
Home: +353-22-47196.
Mobile (IRL) +353-(0)86 1715438

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

