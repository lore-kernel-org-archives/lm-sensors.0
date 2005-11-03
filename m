From: hwang@circadiant.com (Howard Wang)
Date: Thu, 03 Nov 2005 20:57:24 +0000
Subject: [lm-sensors] i2c -dev and i2c bus driver
Message-Id: <24EB6743805F45478251E18DEBF3F6BE8133DD@csserver.circadiant.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

I have got  a question about i2c:

is it possible for one i2c bus driver to be used for two i2c busses ?
if yes, then how ?

currently I am using scx200_i2c bus driver and i2c-dev device driver, it
can only detect one bus. the i2c device is microchip 24C04. 

thanks for the help.

howard

