From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Sun, 03 Dec 2006 08:49:38 +0000
Subject: [lm-sensors]
Message-Id: <45728FA2.90707@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thomas Dohl wrote:
> Hi Udo,
> 
> thank you very much!
> Yes it works.

So we might have the same problem.
In my situation I have a VIA EK8000 which has the fans running during a
boot until the kernel loads/starts. Then the fans stop. So is it a Linux
issue?
When the w83627hf module is loaded with the reset=1 parameter the fans
start again. Fancontrol is functional (although I do not use it).

What can we do to find out more?

