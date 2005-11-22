From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 22 Nov 2005 21:54:37 +0000
Subject: [lm-sensors] [PATCH] Support for Barco LTP->DVI parport I2C
Message-Id: <87acfw5rpc.fsf@48ers.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <87oe4d4uit.fsf@48ers.dk>
In-Reply-To: <87oe4d4uit.fsf@48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>>>> "Jean" = Jean Delvare <khali@linux-fr.org> writes:

 Jean> Hi Peter,
 >> The following patch adds support for the Barco LTP->DVI I2C adapter to
 >> the i2c-parport driver.

 Jean> Looks good except for the extra blank line.

Good.

 Jean> Can you please tell more about that device? I googled for K5800236 but
 Jean> no match. I also don't understand how a LTP->DVI converter is possible
 Jean> at all. Please enlighten us.

Certainly. It's a parport I2C adapter with a DVI connector on it which
we use for writing the DDC eeproms during production of our Barco
displays. The reason for the DVI connector is just for easy wiring as
you can then use a standard DVI cable for it.

The K58000236 number is the internal Barco order number for the
adapter.

I can provide you the schematics if you are interested, but it's
basically just a 74128 line buffer and a few diodes and resistors.

-- 
Bye, Peter Korsgaard
