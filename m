From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: A question when test W83792D driver on another motherboard
Message-Id: <Pine.LNX.4.58.0503031253360.25688@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello Chunhao,

> I don't, sorry. The information provided by Asus (write an arbitrary
> value to an arbitrary port) isn't sufficient for us to understand what
> happens. We would need detailed information on what chip we attept to
> control at this port and how that chip works, and also details on how
> the SMBus is wired. Without that information, I just cannot tell why the
> SMBus works first and then suddenly fails.

Plus this information we will need the base address of that ISA device so
we can put "request_region" to the quirk.c file. (Also if the base adr is
not fixed we would need the detection method how to get the base adrress,
from some PCI config space maybe?)

I'm fully agreeing with Jean. There only a little left you can do.

Now you can only check the logs (syslog, messages, debug) if you can see
problems from piix4 bus driver. If so maybe it would be possible to modify
the piix4 bus driver to test if smbus is busy or not before trying to
write. (This does some asus software too)

I found here some monitoring software from ASUS to this board
 ftp://www.asuscom.de/pub/ASUS/mb/Socket604/NCLV-D/ASMS/

If you would unzip/unrar the files you would find
aswm_core-2.0-48.8.0rhat.i386.rpm
(or for other redhat systems)

if you will look into
you would find

drvsrc.tgz  (source code for binary stuff "glue logic")

and there ghaio.c

With such function:

static int DetectI2CBusy(void)
{
        // Detect and avoid I2C bus busy
        if ( (inb(SMBusBaseAddress + RCC_STATUS_REG) & 0x1D ) != 0 ) {
                outb(0xFF, SMBusBaseAddress + RCC_STATUS_REG); // Reset status register
        block_sleep_tick(I2C_SLEEP_TIME);
                if ( (inb(SMBusBaseAddress + RCC_STATUS_REG) & 0x1D ) != 0
) {
                        DBGMSG("(DetectI2CBusy): Killing I2C Command...\n");
                        outb(0x02, SMBusBaseAddress + RCC_CONTROL_REG); //  kill
                block_sleep_tick(I2C_SLEEP_TIME);
                        outb(0xFF, SMBusBaseAddress + RCC_STATUS_REG); // Reset status register
                block_sleep_tick(I2C_SLEEP_TIME);
                        if ( (inb(SMBusBaseAddress + RCC_STATUS_REG) & 0x1D ) != 0 )
                                return 1; //return fail
                }
        }
        return 0;
}

//======================================// SMBus Send Byte
//======================================int I2CSendByte_RCC(ULONG SlaveAddress, UCHAR * value)
{
        UCHAR status;
        UCHAR ctrlreg = RCC_CONTROL_REG_START | RCC_CONTROL_REG_CMDBYTE;

        down(&SMBusSemaphore);

        outb(0xFF, SMBusBaseAddress + RCC_STATUS_REG);  // Reset status
        block_sleep_tick(I2C_SLEEP_TIME);

        if (DetectI2CBusy()) {
                ERRMSG("(I2CSendByte_RCC): I2C is busy!\n");
                up(&SMBusSemaphore);
                return 1;
        }

        outb(SlaveAddress & 0xFE, SMBusBaseAddress + RCC_SLAVE_ADDR_REG);
// Slave Address
        outb(*(UCHAR *)value, SMBusBaseAddress + RCC_COMMAND_REG);      //
Data
        outb(ctrlreg, SMBusBaseAddress + RCC_CONTROL_REG);      // I2C
Format


and so on....

I think our driver first writes and then check if it was successful.

Plus could you please provide "lspci -v" output command form that
motherboard? It seems there is some IMPI host (at least the asus sources
tells so, maybe that has something to do with it)

regards

Rudolf
