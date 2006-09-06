From: michael@walle.cc (Michael Walle)
Date: Wed, 06 Sep 2006 23:02:07 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060906230207.GA10904@thanatos.lan.walle.cc>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David Hubbard <david.c.hubbard at gmail.com> schrieb am Wed, Sep 06, 2006 at 03:42:08PM -0600:
> Hi all,
> 
> On 9/6/06, Jean Delvare <khali at linux-fr.org> wrote:
> >No, actually the error occurs before that. You didn't add the Super-I/O
> >ID of the W83627DHG in w83627ehf_find, so that function will return
> >-ENODEV.
> 
> I'll make the changes when I get home and send out an updated patch &
> w83627ehf.c tonight. Thanks for the feedback.

Hi,

With the correct SuperIO ID and mask (0xa020/0xfff0) the driver seems to work
here on:
  Linux thanatos 2.6.17.7-mh1 #16 SMP PREEMPT Thu Sep 7 00:21:21 CEST 2006
  i686 Intel(R) Core(TM)2 CPU          6400  @ 2.13GHz GNU/Linux

But fan5_input (my second case fan) jumps between 0 and something around
30000 RPM.
If I slow down my other case fan by hand (fan1), I'll get wrong values, too
(around 12000k).

Also the fan?_min have some strange values:
  thanatos device # cat fan?_min
  10546
  2960
  10546
  10546
  337500


-- 
Sincerly,
 Michael Walle



