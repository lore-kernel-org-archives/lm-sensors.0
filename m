From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 11 Apr 2006 18:02:48 +0000
Subject: [lm-sensors] w83l785r driver
Message-Id: <443BEF48.5030709@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <443BE8D3.6050906@sh.cvut.cz>
In-Reply-To: <443BE8D3.6050906@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Lonni,

Thanks for the quick answer. I'm not the person who seeks the help but users
which do seek help from me. I'm the member of lm-sensors group that
develops and maintains the sensor drivers for the Linux kernel. There is
the unified infrastructure for sensors handling and drivers for monitoring chips.

This unified infastructure means that any application can be used to access the sensors data
which are exported to user programs. Making it closed and locked just to one apps may not fit
the user needs at all. Just imagine the user has some favourite application like gkrellm
and wants to see the GPU temp there.

Opening the drivers for i2c access will enable you to use our hwmon drivers for chips
commonly found on the graphics cards. This would mean it would reduce you the time
to develop the driver to access the chip on your own. Moreover, we are taking care of
that the drivers will work nice in any future linux version.

Some companies like Asus, Tyan  and Winbond are working with us tightly on this sensors
field. If you want to join the cooperation, I'm offering help to nVidia whith opening the drivers
for i2c bus and integrating them to the kernel.

Please forward this email to the responsible manager, or if you need more information
contact me directly, or via the lm-sensors mailing list.

Thank you,

Regards
Rudolf

