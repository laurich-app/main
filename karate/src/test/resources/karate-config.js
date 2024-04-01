function fn() {
  const BASE_URL = karate.env
  var config = {
    BASE_URL,
    pauseIfNotPerf: true,
  };
  return config;
}
