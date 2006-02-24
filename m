From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 24 Feb 2006 19:04:25 +0000
Subject: [lm-sensors] Winbond PC87591 request for driver
Message-Id: <43FF58B9.6060508@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <2afd0d230602151328x3c42e1fcr3efd6f87acedf2cc@mail.gmail.com>
In-Reply-To: <2afd0d230602151328x3c42e1fcr3efd6f87acedf2cc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ymu at Winbond.com.tw wrote:
> Hi,
> 
> Can you get any sensors information in BIOS?
> For examples,  voltage or temperature.

Yep good question, this chip does not export the bus with A/D and access to the temps/fans
must be done with conjuction of chip programming which can be arbitrary (and we cant support that)

If you want to know the temps, please try using acpi -V command.

Regards
Rudolf

