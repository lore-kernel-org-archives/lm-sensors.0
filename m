From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Jan 2010 08:45:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asus_atk0110) Do not fail if MBIF
Message-Id: <20100118094556.1bf88126@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100117220534.GA6226@nb-core2.darkstar.lan>
In-Reply-To: <20100117220534.GA6226@nb-core2.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 17 Jan 2010 23:31:31 +0100, Juan RP wrote:
> On Sun, 17 Jan 2010 23:05:34 +0100
> Luca Tettamanti <kronos.it@gmail.com> wrote:
> 
> > MBIF (motherboard identification) is only used to print the name of
> > the board, it's not essential for the driver; do not fail if it's
> > missing. Based on Juan's patch.
> > 
> > Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
> 
> Signed-off-by: Juan RP <xtraeme@gmail.com>

Applied, thanks!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
