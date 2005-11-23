From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 23 Nov 2005 12:45:22 +0000
Subject: [lm-sensors] [PATCH] Support for Barco LTP->DVI parport I2C
Message-Id: <pGkjoN9o.1132746302.2758780.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <87oe4d4uit.fsf@48ers.dk>
In-Reply-To: <87oe4d4uit.fsf@48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Peter,

On 2005-11-22, Peter Korsgaard wrote:
> Certainly. It's a parport I2C adapter with a DVI connector on it which
> we use for writing the DDC eeproms during production of our Barco
> displays. The reason for the DVI connector is just for easy wiring as
> you can then use a standard DVI cable for it.
>
> The K58000236 number is the internal Barco order number for the
> adapter.

OK, I get it now. You don't really get the video signal through the
parallel port. Pfew :)

Is there any reason why someone outside of Barco would use that interface
and driver?

May I have a Barco device for free, just to test the driver? :)
Just kidding...

--
Jean Delvare
