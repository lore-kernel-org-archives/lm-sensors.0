From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Fri, 30 Jun 2006 19:23:08 +0000
Subject: [lm-sensors] ipmi-smb, missing in my kernel config?
Message-Id: <253818670606301223j5d5e6b13td50d19f882a16d52@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0606300800320.2191@gubbie.home>
In-Reply-To: <Pine.LNX.4.64.0606300800320.2191@gubbie.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nick,

On 6/30/06, Nick Ellson <grimm at nickellson.com> wrote:
>
> Just curious if anyone has tried setting up OpenIPMI to help get
> lm-sensors to see the Intel BMC chip on the SMB bus?

At the moment lm-sensors for 2.6 doesn't support IPMI, I'm working on
a new driver ipmisensors which I hope to have a released version you
can test in a couple of weeks at most. You can check the website to
see the current status  (http://bmcsensors-26.sourceforge.net/). For
now you might want to try using something like ipmitool to check
sensor readings.

Yani

