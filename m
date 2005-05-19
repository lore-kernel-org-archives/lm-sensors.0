From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: lm-sensors are out of control !
Message-Id: <sjiqtGwn.1109764491.7108440.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <3948f2f205030118272afd83f0@mail.gmail.com>
In-Reply-To: <3948f2f205030118272afd83f0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Dimitris,

> What is even more strange is that gkrellm displays the correct CPU
> temp but when i run sensors its wrong.
> And yes i just upgraded to 2.6.11

gkrellm does not use libsensors. I consider it an error since it means
more work for the maintainers to catch up with the changes and fixes we
do to the various hardware monitoring drivers, let alone the fact that
they have to handle the labeling and scaling of inputs on their own, but
in some rare cases it has the side effect of making gkrellm immune to
problems that will affect all programs using libsensors.

Hope that helps,
--
Jean Delvare
