<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */

define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', '/dev/stdout' );
define( 'WP_DEBUG_DISPLAY', true );

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', getenv('WORDPRESS_DB_NAME') );

/** Database username */
define( 'DB_USER', getenv('WORDPRESS_DB_USER') );

/** Database password */
define( 'DB_PASSWORD',  getenv('WORDPRESS_DB_PASSWORD') );

/** Database hostname */
define( 'DB_HOST', getenv('WORDPRESS_DB_HOST') );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'K8$oU;]Pa C3h*Mkt/DJ7S7mb(CVmm~UIi^(_/Y}`/>8$z3&Ae9D3.7~5,@btnIw' );
define( 'SECURE_AUTH_KEY',  '>2*)-G;vScIJn_`>q$q<P!gGifu>I^^@|bo7%p1xVas/+&ey2bUEDl/FWzl#QVBZ' );
define( 'LOGGED_IN_KEY',    'U&Kkwd0$q:5CEIZPG.rwi+F4M10E&[4]at/*}(/;svz)2~vM/U+MMu8VuN#Pj9=^' );
define( 'NONCE_KEY',        ':U?<Om>W(6dQJ[Oam1)DH^K*W#JSf}%m z}yNnf~(~0QvukSTU6rG9[cZ|/md;CP' );
define( 'AUTH_SALT',        '_Z9t1gV>s^g6!?.jWM<wFOc)?rR<4Xk#z|lMwsb[0Dz;P7=O)I&<LV01Iw^TX+Kf' );
define( 'SECURE_AUTH_SALT', 'd uiaQD3OU&(q}7Z`{RRc$=r{>Vo6~>?mXIi9R*&=XcO|$j2`ZS)0iR;1:U}3QiD' );
define( 'LOGGED_IN_SALT',   'u[$[G5OQHYdV+5%}qv`l*4s5Pimk*uS)YGpB#?eNFFaJ=l`<GALU~4[XO *4Fl2-' );
define( 'NONCE_SALT',       '$0Z%TDZ }{<4XgG/Q_USMFZgcBGX0O i9NZ8fjtQKc/H5]7#C=^=K8o;Jo$2-#=&' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 *
 * At the installation time, database tables are created with the specified prefix.
 * Changing this value after WordPress is installed will make your site think
 * it has not been installed.
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/#table-prefix
 */
$table_prefix = getenv('WORDPRESS_TABLE_PREFIX');

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */

/* Add any custom values between this line and the "stop editing" line. */

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
