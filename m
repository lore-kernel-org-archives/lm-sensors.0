From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [ralf.roesch@rw-gmbh.de: Fix in eeprom.c]
Message-Id: <20040329160757.GA1802@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Ralf R?sch <ralf.roesch@rw-gmbh.de> -----

From: Ralf R?sch <ralf.roesch@rw-gmbh.de>
To: frodol@dds.nl
Subject: Fix in eeprom.c
Importance: Normal
X-Spam-Status: No, hits=-5.0 required=5.0 tests=ASCII_FORM_ENTRY,UNIFIED_PATCH version=2.20
X-Spam-Level: 

Hi Frodo,

what do you think about this fix?

regards
Ralf

Roesch & Walter___________________________________________
Industrie-Elektronik GmbH * Tel.: +49-7824 / 6628-0 
Im Heidenwinkel 5         * Fax:  +49-7824 / 6628-29
D-77963 Schwanau          * mailto:ralf.roesch@rw-gmbh.de 
Germany                   * WWW: http://www.rw-gmbh.de

Index: eeprom.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/eeprom.c,v
retrieving revision 1.50
diff -u -r1.50 eeprom.c
--- eeprom.c    17 Jan 2004 11:14:00 -0000      1.50
+++ eeprom.c    29 Mar 2004 14:31:06 -0000
@@ -202,7 +202,7 @@
        }

        data = (struct eeprom_data *) (new_client + 1);
-       memset(data, 0xff, EEPROM_SIZE);
+       memset(data->data, 0xff, EEPROM_SIZE);
        new_client->addr = address;
        new_client->data = data;
        new_client->adapter = adapter;


----- End forwarded message -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
