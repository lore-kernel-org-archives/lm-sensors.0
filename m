From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 20 Jul 2014 12:03:00 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (tmp421) Drop FSF mailing address
Message-Id: <20140720140300.4e931503@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404680101-8843-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1404680101-8843-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun,  6 Jul 2014 13:55:01 -0700, Guenter Roeck wrote:
> The FSF mailing address can and will change over time,
> so drop it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/tmp421.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
> index f1ce845..cd1915d 100644
> --- a/drivers/hwmon/tmp421.c
> +++ b/drivers/hwmon/tmp421.c
> @@ -13,10 +13,6 @@
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  
>  /*

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
