From: michael@wells.org.uk (Michael Wells)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: Intel se7500wv2 lm sensors?
Message-Id: <000001c2f2ac$2b4edac0$1108a8c0@corona>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have RH8.0 installed on an Intel se7500wv2 board, and am trying in
vain to
access the onboard sensors via IPMI. The Intel Server Management
software
CLI won't let me in (and ISM client software can't connect). I've come
to
the conclusion that the service partition must be installed before ISM
can
be used. Unfortunately, it's too late as the box is colocated. I do have
serial access but can't seem to get much further regarding ISM. Please,
someone correct me if I'm missing something!

SO...

I was wondering if there is a simple way to get sensor data from the
board,
which does not require the full ISM product to be installed. Can LM
Sensors
do it? Or is there anything else I can do to get access to the
environmental
data? Alternatively, does anyone know of an FAQ for getting ISM or IPMI
working under Linux?

Thanks!

Michael Wells
