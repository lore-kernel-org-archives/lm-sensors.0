From: Thomas Trepper <thomas.trepper@blueclaim.com>
Date: Tue, 03 Jun 2014 05:18:57 +0000
Subject: [lm-sensors] Supermicro A1SAi
Message-Id: <DE79CDD8-60B1-45D0-85B6-3E63F4204929@blueclaim.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all,=20

I was wondering if there is support for the Supermicro A1SAi? I have done t=
his:

# sensors-detect revision 6031 (2012-03-07 17:14:01 +0100)
# System: Supermicro A1SAi [123456789]
=85
Now follows a summary of the probes I have just done.
Just press ENTER to continue:=20

Driver `to-be-written':
  * ISA bus, address 0xca2
    Chip `IPMI BMC KCS' (confidence: 8)

Driver `coretemp':
  * Chip `Intel digital thermal sensor' (confidence: 9)

Are there any chances to get also voltage and fan beside the core-temp? Can=
 anybody maybe point be to the right direction?

Thanks a lot in advance.

Best,
Thomas


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
