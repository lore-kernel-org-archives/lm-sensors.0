From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: vt8231 and kernel 2.6.10?
Message-Id: <4217758F.1050403@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141301.52274.morten@tuxtail.org>
In-Reply-To: <200502141301.52274.morten@tuxtail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

we can't help you unless you send us the error messages or a
good description of the problem :)


Morten Schmidt wrote:
> Hi
> 
> I have been trying for more then a week now. I can't seem to get the "make 
> user" and "make user_install" to work, when compiling the lm_sensors.2.9.0...
> 
> Do I have to do something speciel for this to work?
> 
> I have a "Via EPIA 800" board
> 
> lspci:
> maggie:/home/smet# lspci
> 0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] (rev 
> 05)
> 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP]
> 0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8231 [PCI-to-ISA Bridge] 
> (rev 10)
> 0000:00:11.1 IDE interface: VIA Technologies, Inc. 
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 0000:00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
> Controller (rev 1e)
> 0000:00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
> Controller (rev 1e)
> 0000:00:11.4 Bridge: VIA Technologies, Inc. VT8235 ACPI (rev 10)
> 0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 
> Audio Controller (rev 40)
> 0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] 
> (rev 51)
> 0000:01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1 
> (rev 6a)
> 
> 
> result of sensors-detect:
> #----cut here----
> # I2C adapter drivers
> i2c-viapro
> i2c-isa
> # I2C chip drivers
> eeprom
> vt8231
> #----cut here----
> 
> 
> Thank you in advance
> /morten
> 

