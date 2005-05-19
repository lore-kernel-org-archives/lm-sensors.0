From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: (from cvs) sensors binary compile probs on rh8
Message-Id: <3DF93866.7070502@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


FYI-

gcc -o prog/sensors/sensors prog/sensors/main.ro prog/sensors/chips.ro 
-Llib -lsensors
lib/libsensors.so: undefined reference to `log'
lib/libsensors.so: undefined reference to `exp'
collect2: ld returned 1 exit stat


Phil
