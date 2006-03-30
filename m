From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 30 Mar 2006 21:36:57 +0000
Subject: [lm-sensors] unable to set lm_sensors
Message-Id: <442C4F79.5030609@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200603252150.53616.mmodem00@netvisao.pt>
In-Reply-To: <200603252150.53616.mmodem00@netvisao.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ze,

Sorry for delay, seems all other people have other stuff to do.


Z? wrote:
> I have a notebook Acer 5024 WLMi that haves a cpu Turion 64 ML-34 and i have 
> installed Mandriva 2006 x86_64.
> 
> I have installed lm_sensors //nd run sensors-detect but i cant get it 

>  Sorry, no chips were detected.
>  Either your sensors are not supported, or they are
>  connected to an I2C bus adapter that we do not support.

Well notebooks usually do the thermal management on their own. The CPU temp can be read via ACPI. USe for example
acpi -V
command to see the temperature. Have you any strong reason to need to have lm-sensors?

regards
Rudolf

