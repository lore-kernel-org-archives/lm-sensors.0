From: =?UTF-8?Q?Ond=c5=99ej_Lyson=c4=9bk?= <olysonek@redhat.com>
Date: Fri, 23 Nov 2018 18:53:38 +0000
Subject: Announcing lm_sensors 3.5.0
Message-Id: <a47a36f6-228a-1ca5-ec84-c772830a3a87@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi,

after a bit of a pause, lm_sensors 3.5.0 has been released. Get it from
GitHub [1].

The release features improved device detection, sample configuration
files imported from lm-sensors.org, improved hwmon device classification
as a fix for a problem with chips disappearing with 4.19+ kernels,
support for JSON output in the sensors program and more. See the CHANGES
file [2] for a detailed list of user-visible changes.

As you probably already know, the project has been moved to GitHub [3]
and a website has been created for it on the hwmon wiki [4].

[1] https://github.com/lm-sensors/lm-sensors/releases
[2] https://github.com/lm-sensors/lm-sensors/blob/V3-5-0/CHANGES
[3] https://github.com/lm-sensors/lm-sensors
[4] https://hwmon.wiki.kernel.org/lm_sensors

Ondřej Lysoněk
