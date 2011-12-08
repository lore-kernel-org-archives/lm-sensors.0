From: Bjoern Gerhart <oss@extracloud.de>
Date: Thu, 08 Dec 2011 22:04:54 +0000
Subject: Re: [lm-sensors] [PATCH] f75375s: added Fintek f75387 support
Message-Id: <CABRa2TLg6-Qi1v-w=V1ODm5+LFsNN3CtEgyRHSB707dgyztNuA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABRa2TKyTHBSZiWMxZZqC2Y=ZZNTQQt_3BXTrt6JzQzj0OsfNw@mail.gmail.com>
In-Reply-To: <CABRa2TKyTHBSZiWMxZZqC2Y=ZZNTQQt_3BXTrt6JzQzj0OsfNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guenter,

so for solving the other issues you mentioned, I'd first apply your
set of 4 patches on the original f75375s. Then I'd implement my f75387
related modifications within your latest review proposals, test the
resulting binary module on my f75387 hardware and then create a fifth
patch.

Would that order lead to a valid set of patches?

--
Bj=F6rn Gerhart

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
