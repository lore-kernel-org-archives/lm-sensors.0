From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: website update: supported drivers & new drivers
Message-Id: <20030821035500.GA2220@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all:

Could someone make the following changes to the "supported drivers" page?
These two should replace all i2c-sis645 entries:

SIS | 645/961   | yes | i2c-sis645 | 2.6.5

SIS | 645DX/961 | yes | i2c-sis645 | 2.7.0
    | 735       |     |            |
    | 650/961   |     |            |

And on the "new drivers" page, this should replace all i2c-sis645 entries:

SIS | 648/96x   | yes | i2c-sis645 | 2.8.0
    | 651/96x   |     |            |
    | 745/96x   |     |            |
    | 746/96x   |     |            |
    | xxx/962   |     |            |
    | xxx/963   |     |            |

Also, please remove the corresponding chipsets from the "not planned"
entry above it.

And in the chips section of new drivers...

Asus | ASB100 "Bach" | yes | asb100 | no | ????? | In progress by MMH,
                                                   check CVS.

Asus | ASM58 "Mozart" | no | asm58 | no | ????? | TODO: MMH when
                                                  done with ASB100.

ITE | 8707 | no | not planned | | | ITE won't release datasheet, but
                                    says sensor part is identical to 8712.
                                    (from email to MMH)

I hope that's all clear... let me know otherwise.

Thanks and regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
