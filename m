From: rkimber@ntlworld.com (rkimber@ntlworld.com)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: fan control question
Message-Id: <20050205151509.7b26200c.rkimber@ntlworld.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have tried lm_sensors with Suse 9.1, the current Mandrake, and the current Ubuntu.

In the bios on my MSI K8T Master2 -FAR, I have the option to set a threshold for the CPU fans so that below a certain temperature they run quietly and not at the full
'sounds-like-a-jet-engine' speed.  When I switch on they run full for a couple of minutes and then slow down to something like half speed.

Under Suse 9.1 this all works fine, but if I use Ubuntu or Mandrake, enabling lm_sensors causes the CPU fans to run at full speed without ever going quiet.

Why should this be so?  Is Ubuntu lm_sensors doing something to overrride the bios setting? Otherwise, sensors appear to work fine.

I'd appreciate any guidance you can offer.

- Richard Kimber.
