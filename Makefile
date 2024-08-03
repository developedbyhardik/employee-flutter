build-ipa:
	@echo "Building ipa..."
	# flutter clean
	flutter build ipa --dart-define-from-file=.env

build-apk:
	@echo "Building apk..."
	# flutter clean
	flutter build appbundle --release --dart-define-from-file=.env

run:
	@echo "Running app..."
	flutter run --dart-define-from-file=.env

build-model:
	@echo "Building model..."
	flutter pub run build_runner build 