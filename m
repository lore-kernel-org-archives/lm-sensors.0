From: yrsh2scp@mbox.nc.kyushu-u.ac.jp (Yoshifumi R. Shimizu)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: On README.p4b?
Message-Id: <030624172834.M0184093@mbox.nc.kyushu-u.ac.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Developers of the lm_sensor project:

      My name is Yoshifumi Shimizu.  I have a question about the README.p4b,
which is on the SMBus problem of ASUS Pentimum4 motherbaords.

      In the "README.p4b" file, it says:

----------------------------------------------------------------------------
>It turnes off (!) the bits number 8 and 3 in the LPC register of the ICH2.
>This you can also try as root with setpci and pcitweak.
>First do a:
>
>setpci -d 8086:2440 f2.w
>
>You will get an hex number VAL - in my case 148 (Hex)-, where you have to 
>erase the two bits - in my case you get 40 (Hex).
>Then do a:
>
>setpci -d 8086:2440 f2.w=VAL
> (snip)
----------------------------------------------------------------------------

while in the "p4b_smbus.c"

----------------------------------------------------------------------------
>/* 
> * Checks whether SMBus is enabled and turns it on in case they are not. 
> * It's done by clearing Bit 8 and 4 in i801 config space F2h, PCI-Device 0x8086:0x2440(ICH2)/0x24c0(ICH4)
> */
>static int
>i801smbus_enable(struct pci_dev *dev){
>	u16  val   = 0;
>
>	pci_read_config_word(dev, 0xF2, &val);
>	DBG("i801smbus: i801smbus config byte reading 0x%X.\n", val);
>	if (val & 0x008) {
>		pci_write_config_word(dev, 0xF2, val & 0x77);
>		pci_read_config_word(dev, 0xF2, &val);
> (snip)
----------------------------------------------------------------------------

So it seems that the content of two are conflicting:

   README.p4b        --->   bits 8 and 3 (counting from 0)
   p4b_smbus.c       --->   bits 7 and 3 (counting from 0)

which is correct?   This is my first question.  The second is, of course,
related to the first:  If what is written in "p4b_smbus.c" is correct,
then the data is byte, so that it should be:

        pci_write_config_byte(dev, 0xF2, val & 0x77);
                         ^^^^

        pci_read_config_byte(dev, 0xF2, &val);
                        ^^^^
in stead of "***_word()".  And then, in the README.p4b, one has to change?:

        setpci -d 8086:2440 f2.b=VAL
                              ^^
(for this, I'm not sure.  Is it correct?  I am not a linux user!  Please,
let me know if it's correct).  If what is written in "README.p4b" is
correct, on the other hand, then the data is word, but, of course, then
the mask should be changed:

        pci_write_config_word(dev, 0xF2, val & 0xFEF7);
                                               ^^^^^^
What is correct?


     I am developing a motherboard monitor program for FreeBSD
(it also runs on Linux box, though), named "xmbmon/mbmon", which is
a userland program and not of device driver type like lm_sensors.

   http://www.nt.phys.kyushu-u.ac.jp/shimizu/download/download.html

Your project is a great help for developing the program. I appreciate
it so much.

     Now, many users of ASUS Pentium4 motherboards had the same
problem when using "xmbmon/mbmon", so I want to write down a kind of
FAQ for it.  So I looked into the your project files.  But, because of
the inconsistencies mentioned above, I cannot write down.  I cannot
either check by myself, since I don't have any ASUS Pen4 motherboards,
so I hope to clear out what is correct by asking you.  Thank you.

     With best regards,                   Yoshifumi R. Shimizu
