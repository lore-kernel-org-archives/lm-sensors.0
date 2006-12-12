From: david.c.hubbard@gmail.com (David Hubbard)
Date: Tue, 12 Dec 2006 16:16:01 +0000
Subject: [lm-sensors] FW: Tyan GS12
Message-Id: <4dfa50520612120816o32244f5n1f356856f004c495@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612091617.kB9GH16e029812@srv1.nickelnetworks.com>
In-Reply-To: <200612091617.kB9GH16e029812@srv1.nickelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

You are using the lm85 driver. I found information at
http://www.lm-sensors.org/browser/lm-sensors/trunk/kernel/chips/lm85.c
which seems to indicate you will want to ask Margit Schubert-While
<margitsw at t-online.de> for help locating the PWM frequency and
debugging your fan behavior. Again, I'm not going to be able to debug
the driver. But I can point you to the people who may be able to help.

Also, you will want to update your version of sensors to the latest
released version (2.10).

David

