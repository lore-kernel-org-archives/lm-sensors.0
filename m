From: Thomas.lm_sensors@NOSPAM-lontzen.net (Thomas)
Date: Fri, 24 Feb 2006 10:46:19 +0000
Subject: [lm-sensors] sensors with piix4/IBM
Message-Id: <43FEE3FB.4010306@NOSPAM-lontzen.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <43FA13EA.3010309@NOSPAM-lontzen.net>
In-Reply-To: <43FA13EA.3010309@NOSPAM-lontzen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Noone to help me? Please please! :-(

Thomas

Thomas wrote:

> Hi,
>
> I need help! I searched and didn't find anything that could help me.
>
> I have an IBM desktop computer here, installed with Gentoo/Linux:
> genta ~ # uname -a
> Linux genta 2.6.15.1 #5 PREEMPT Wed Feb 15 20:42:34 CET 2006 i686 
> Pentium III (Katmai) GenuineIntel GNU/Linux
> genta ~ # lspci
> 00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX 
> Host bridge (rev 03)
> 00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP 
> bridge (rev 03)
> 00:02.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
> 00:02.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
> 00:02.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 
> 01)
> 00:02.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
> 00:03.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 
> 100] (rev 05)
> ...
>
> As i found on the website and the kernel informations, piix4 is 
> supported so lets modprobe it:
> genta ~ # modprobe i2c-piix4
> genta ~ # sensors
> No sensors found!
>
> Hmm ... lets ask dmesg:
> genta ~ # dmesg
> ...
> piix4_smbus 0000:00:02.3: Found 0000:00:02.3 device
> piix4_smbus 0000:00:02.3: IBM Laptop detected; this module may corrupt 
> your serial eeprom! Refusing to load module!
> piix4_smbus: probe of 0000:00:02.3 failed with error -1
>
> Help! What's wrong? What can i do? I'm sure that that is NOT a Laptop! 
> ;-)
>
> PS: Please remember to remove the NOSPAM information at the email 
> domain. "lontzen.net" is the right email domain.
>
> Greetings - Thomas
>


