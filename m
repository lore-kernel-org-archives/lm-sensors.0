From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Mon, 05 Dec 2005 18:19:47 +0000
Subject: [lm-sensors] [PATCH 0/3] w1 : change data type, move code,
Message-Id: <20051205181947.GA20634@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512051006s125a86bp1e96bf58f29b6b7@mail.gmail.com>
In-Reply-To: <808c8e9d0512051006s125a86bp1e96bf58f29b6b7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 05, 2005 at 12:06:46PM -0600, Ben Gardner (gardner.ben at gmail.com) wrote:
> This three-part series does the following:
> 1. Change the type 'unsigned long' member of 'struct w1_bus_master' to 'void *'
> 2. Move w1 bus master code into 'w1/masters' and move w1 slave code
> into 'w1/slaves'
> 3. Add the DS2482 I2C-to-w1 bridge driver
> 
> Signed-off-by: Ben Gardner <bgardner at wabtec.com>

I will take a look tomorrow and if there are no problems will push it
upstrem.

Thank you.

-- 
	Evgeniy Polyakov

