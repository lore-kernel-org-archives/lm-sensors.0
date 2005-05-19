From: dtor_core@ameritech.net (Dmitry Torokhov)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <200505060153.54288.dtor_core@ameritech.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani,

On Friday 06 May 2005 01:40, Yani Ioannou wrote:
> We would probably want to define another DEVICE_ATTRIBUTE like macro
> or add a void * parameter to the DEVICE_ATTRIBUTE macro. Any opinions
> on which way to go? This might be done for the other *_ATTRIBUTE
> macros too.
> 

No, I don't think so. Again, macros are normally used to initialize
statically allocated attributes, exposing void * pointer does not do
them any good. It can only lead to bugs when driver writer misses the
fact that pointer is shared between all instances of attribute.

-- 
Dmitry
