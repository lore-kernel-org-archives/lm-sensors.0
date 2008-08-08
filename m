From: Matt Roberds <mattroberds@cox.net>
Date: Fri, 08 Aug 2008 23:16:58 +0000
Subject: Re: [lm-sensors] Problems with a MSI K8T Neo2 v2.0 (wrong voltages
Message-Id: <Pine.LNX.4.64.0808081803020.29903@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <7641eb8f0808081145q3ad0208ftaa94915e52e0043@mail.gmail.com>
In-Reply-To: <7641eb8f0808081145q3ad0208ftaa94915e52e0043@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 8 Aug 2008, Beth wrote:
> (I am using ubuntu 8.04 and kernel 2.6.24-19-generic, with an AMD
> Athlon(tm) 64 X2 Dual Core Processor 4200+)

What version of sensors are you running?  (Say
sensors -v
to find out.)

> The temps seems to be accurate but the voltages are wrong.

See
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Somemeasurementsarewayoutofrange.Whathappened
and
http://www.lm-sensors.org/wiki/FAQ/Chapter3#a-5Vand-12Vreadingsarewayoutofrange


> And if I try to do a pwmconfig no correlations are detected:

Have you tried disabling or at least changing the speed and fan related
settings in the BIOS to see if that affects anything?

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
