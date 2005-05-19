From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: insmod of the i2c-amd756 failed.
Message-Id: <20031006225830.7deae107.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <99F2150714F93F448942F9A9F112634CC35ACA@txexmtae.amd.com>
In-Reply-To: <99F2150714F93F448942F9A9F112634CC35ACA@txexmtae.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I installed lm_sensors 2.8.0 and i2c 2.8.0 on the SuSe machine with
> kernel 2.4.19. The installation went well. I ran sensors-detect and
> the program detected AMD-8111 SMBus 2.0 and AMD-8111 ACPI. The program
> sucessfully installed the i2c-amd8111 for the SMB 2.0 but failed to
> install i2c-amd756 for the AMD-8111 ACPI. The details are in the
> included file that I captured when I ran the sensors-detect program.
> The dmesg just gives the module name and its version number. Do you
> have any idea on what is going on and any sugestion on anything that I
> need to do.

Please give a try to 2.8.1 (released today) in case it changes
something. It is possible that i2c-amd8111 and i2c-amd756 are mutually
exclusive. Try unloading i2c-amd8111 before loading i2c-amd756.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
