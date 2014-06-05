<?php
use \samson\cms\App;

/**
 * Контроллер по умолчанию для главной страницы
 */
function main()
{
	// Представление для главной
	$result = '';
	
	// Переберем загруженные классы и вызовем обработчик главной страницы если он описан
	foreach ( App::loaded() as $app ) $result .= $app->main();
		
	// Установим представление
	m()	->view('main')
		->title(t('Главная', true))
		->result( $result );
}