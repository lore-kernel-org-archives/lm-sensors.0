From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Mon, 08 Aug 2005 19:04:21 +0000
Subject: [lm-sensors] bmcsensors and ipmi on Poweredge
Message-Id: <25381867050808100347091200@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1123503404.3182.14.camel@localhost.localdomain>
In-Reply-To: <1123503404.3182.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jonathan,

It looks like you haven't loaded the ipmi modules, try loading all of
the ipmi modules before you load i2c-ipmi and bmcsensors and then
sensors -s, and then try sensors again.

Yani
