From: david.goodenough@btconnect.com (David Goodenough)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: Should sensors-detect be merged with Hotplug or Discover
Message-Id: <200405081001.31499.david.goodenough@btconnect.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I realise that some sensors are difficult to detect, but in the cases where 
detection is very reliable should not sensors-detect be merged into 
Hotplug or Discover (probably Discover as I am not aware of sensors
which come and go, although with the hotpluging of memory modules
which themselves might have sensors built in this may arrive) so that
it all happens automatically without a separate sensors-detect stage?

David
