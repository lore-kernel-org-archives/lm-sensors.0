From: Paul Fertser <fercerpav@gmail.com>
Date: Mon, 31 Oct 2011 13:49:07 +0000
Subject: Re: [lm-sensors] [RFC][PATCH] hwmon: add support for MCP3204/3208
Message-Id: <20111031134907.GC1173@home.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <201110311247.p9VClrVx017871@home.pavel.comp>
In-Reply-To: <201110311247.p9VClrVx017871@home.pavel.comp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 31, 2011 at 02:11:23PM +0100, Jean Delvare wrote: 
> If the LSB weight depends on the platform somehow, you may be able
> to pass it as platform data to the I2C slave device, so that the
> driver can scale properly.

Sure, will rework the driver accordingly. Thanks for the fast
response!

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
