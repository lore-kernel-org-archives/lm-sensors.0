From: david.c.hubbard@gmail.com (David Hubbard)
Date: Wed, 06 Sep 2006 21:42:08 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <4dfa50520609061442h2cd2adf3s554d495ed8a70803@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

On 9/6/06, Jean Delvare <khali at linux-fr.org> wrote:
> No, actually the error occurs before that. You didn't add the Super-I/O
> ID of the W83627DHG in w83627ehf_find, so that function will return
> -ENODEV.

I'll make the changes when I get home and send out an updated patch &
w83627ehf.c tonight. Thanks for the feedback.

David

