From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 05 Jul 2006 06:38:17 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <44AB5E59.2040807@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sunil Kumar wrote:
> I actually found that thread after posting here. I am devsk there. So, 
> is there going to be standalone tar release of version 1.1.10? I have 
> AN8-SLI and 1.1.8 is working fine with patch to lm_sensors-2.10.0 
> package. I am also wondering if I really need to go to 1.1.10?
> 

I'm not planning on doing a stand alone release of 1.1.10 as you say
1.1.8 works fine for you and so it does for most others. If the need
arises I may do a stand alone release. But the whole idea is to have
this driver in the kernel and for the kernel to be _the_ place where
development happens. So things are actually going as planned, with 1.1.8
being the last standalone release.

Regards,

Hans



