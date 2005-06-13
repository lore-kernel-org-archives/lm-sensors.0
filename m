From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Mon, 13 Jun 2005 22:25:48 +0000
Subject: [lm-sensors] w83781d.o: Subclient 0 registration at address 0x49
Message-Id: <253818670506131322a184092@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ef564dc05061302175b8427fd@mail.gmail.com>
In-Reply-To: <2ef564dc05061302175b8427fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

For what its worth I get the same problem on a new machine I just put
together (ironically enough so I could test ipmi_sensors on a more
modern BMC - using the Tyan SMDC add-on). The motherboard is a Tyan
2882-D (an updated 2882) and I get:

w83781d 1-0028: Duplicate addresses 0x48 for subclients.

when trying to use w83781d. sensors-detect says I should be able to
access the chip through the ISA bus too, but loading i2c-isa and
w83781d no chip seems to be detected. The motherboard has two smbus
interfaces, one an Smbus 2.0 interface through i2c_amd8111 and
i2c_amd756. Nothing seems to be using i2c_amd8111 though. An adm1027
is also detected and works fine.

Thanks,
Yani

On 6/13/05, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Sukhdeep,
> 
> > The Motherbowrd is from VIAPRO, it's similar to kt400.
> 
> VIA Pro / KT400 is the name of the South Bridge. This doesn't tell me
> the motherboard itself is. Have you no idea? dmidecode [1] may help.
> 
> [1] http://www.nongnu.org/dmidecode/
> 
> > Client found at address 0x29
> > (...)
> > Probing for `Winbond W83782D'... Success!
> >     (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
> > (...)
> > Client found at address 0x2d
> > (...)
> > Probing for `Winbond W83782D'... Success!
> >     (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
> 
> Wow. So it does actually find *two* W83782D chips, which share the same
> subclient addresses. This is no good.
> 
> Can you please provide the output of the following commands:
> i2cdump -y 0 0x29
> i2cdump -y 0 0x2d
> 
> (I assume this is on i2c bus 0; if not, put the correct ID.)
> 
> > Probing for `Winbond W83697HF Super IO Sensors'
> >   Success... but not activated
> 
> And the Super-I/O is there. I suspect that the W83697F has the same ID,
> so we cannot differenciate, but the W83697F has no hardware monitoring
> logical device - which would explain why it is listed as 'not activated"
> here.
> 
> So... the correct modprobe line for you would be:
> 
> modprobe w83781d force_subclient=0,0x29,0x4a,0x4b
> 
> Try it :)
> 
> --
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
