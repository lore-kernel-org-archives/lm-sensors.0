From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 26 Jul 2005 09:45:02 +0000
Subject: [lm-sensors] GA-K8NS 939
Message-Id: <42E5E9C6.70205@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <3805ffe805072514061a264136@mail.gmail.com>
In-Reply-To: <3805ffe805072514061a264136@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Please tell us what modules you load and what chip you are using. Also please provide the output of sensors-detect.

Please can you confirm you have it8712 chip? Did you check syslog for a message "polarity ....BIOS" when loading it87 ?
Also I can see one winbond chip near memory socket, but I cant read it from photo.

Blind shot:
modprobe it87 fix_pwm_polarity=1

Thanks

Regards

Rudolf

