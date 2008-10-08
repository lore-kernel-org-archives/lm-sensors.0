From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Wed, 08 Oct 2008 18:36:01 +0000
Subject: Re: [lm-sensors] [PATCH 04/12] adt7470: Fix pwm*-auto-point* to
Message-Id: <20081008183601.GF7726@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011844.12701.12127.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081007011844.12701.12127.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 08, 2008 at 11:25:29AM +0200, Jean Delvare wrote:
> Hi Darrick,
> 
> On Mon, 06 Oct 2008 18:18:44 -0700, Darrick J. Wong wrote:
> > It turns out that Tmin/Tmax should be attached to the temperature sensors, not
> > to the pwm control.  Fix my misinterpretation of the datasheet.
> 
> Really? I'm confused. The ADT7470 has 4 PWM outputs and 10 temperature
> inputs. There are only 4 Tmin registers. How can they be attached to
> temperature inputs? What about inputs temp5 to temp10? I think your
> original interpretation is correct and Tmin is attached to a PWM
> channel, and this patch is incorrect. What makes you think otherwise?

I think I confused myself, because the datasheets for the 7473/7462
claim that Tmin are attached to the temperature inputs, not to the pwm
outputs.  Clearly not the case for the  7470.  Nack on this patch.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
