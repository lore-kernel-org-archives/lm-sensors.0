From: DB <Freddog_de@yahoo.co.uk>
Date: Tue, 05 Jul 2011 20:54:11 +0000
Subject: Re: [lm-sensors] Where are all the sensors?
Message-Id: <4E1379F3.7070303@yahoo.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E0B52A6.1070402@yahoo.co.uk>
In-Reply-To: <4E0B52A6.1070402@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 07/05/2011 10:37 PM, Luca Tettamanti wrote:
> On Tue, Jul 5, 2011 at 9:45 PM, DB<Freddog_de@yahoo.co.uk>  wrote:
>> [   21.121981] f71882fg: Found f71889fg chip at 0x600, revision 21
>> [   21.122030] ACPI: resource f71882fg [io  0x0600-0x0607] conflicts with
>> ACPI region HMOR [mem 0x00000605-0x00000606 pref disabled]
>> [   21.122037] ACPI: If an ACPI driver is available for this device, you
>> should use it instead of the native driver
>
> This means that the BIOS is claiming the hwmon chip for itself;
> starting from 2.6.31 Linux started enforcing this claim, see
> http://lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31.
>
> Asus exposes the hardware monitoring data trough an ACPI interface. If
> you send me a copy of /sys/firmware/acpi/tables/DSDT I'll see if
> there's something usable.
>
> Luca
>

Hi Luca,

I tried cat /sys/firmware/acpi/tables/DSDT & got a lot of characters all 
over the page, nothing really readable.... ls -l gives
   ls -l /sys/firmware/acpi/tables/DSDT
-r--------. 1 root root 0 Jul  5 22:42 /sys/firmware/acpi/tables/DSDT

Here's the last page of the file:

       �pTAAXAAXB��A�B�TTT0
pAAXBTAAXpCMRQBUF0p
BUF1pBUF2pBUF3pMBUFAAXBp
�PSMI["
        �pAAXBMBUFpBUF2cp�PPI1pc�PPI1pTAAXAAXB�PPI1�K�
                                                      �TTT0
�
�L�J�TTT0
pAAXBTAAXpCMRQBUF0p
�BUF1pBUF2pBUF3pMBUFAAXBp
�PSMI["
        �pAAXBMBUFzBUF2
cpCMERBUF0p
�BUF1pBUF2pBUF3pMBUFAAXBp
�PSMI["
        �pAAXBMBUFpBUF2frCMERdpdBUF0p
�BUF1pBUF2pBUF3pMBUFAAXBp
�PSMI["
        �pAAXBMBUFpBUF2gwg
                          brbfbp�PPI2pc�PPI2��b
                                               ��p
                                                  �����PPI2
�"��b
      ��p
         �����PPI2
�
  pb�PPI2
pTAAXAAXB�PPI2��
�TTT0
�����h
�T`7�uF�GV���TTT1p�jTTT1�
                          �TTT1��H�C�TTT1pAAXBTAAXpCMORBUF0p
�BUF1p���kBUF2pBUF3pMBUFAAXBp
�PSMI["
        �
         pTAAXAAXB��_S0_�SS1_S1_�SS3_S3_
�SS4_S4_
_S5_
FPTS_�>h\/_SB_PCI0SBRGSIOShNB2ShSPTSh\/_SB_PCI0SBRGEPTShNPTShAPTShHWAK_\/_SB_PCI0SBRGSIOWhNB2WhSWAKh\/_SB_PCI0SBRGEWAKhNWAKhA


Is there some other way I ought to have looked at the file???

Thanks for your help!!!

Dave

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
