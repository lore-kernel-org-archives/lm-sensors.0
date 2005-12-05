From: gardner.ben@gmail.com (Ben Gardner)
Date: Mon, 05 Dec 2005 18:06:46 +0000
Subject: [lm-sensors] [PATCH 0/3] w1 : change data type, move code,
Message-Id: <808c8e9d0512051006s125a86bp1e96bf58f29b6b7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This three-part series does the following:
1. Change the type 'unsigned long' member of 'struct w1_bus_master' to 'void *'
2. Move w1 bus master code into 'w1/masters' and move w1 slave code
into 'w1/slaves'
3. Add the DS2482 I2C-to-w1 bridge driver

Signed-off-by: Ben Gardner <bgardner at wabtec.com>

