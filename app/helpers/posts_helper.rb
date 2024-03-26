module PostsHelper

  # avant de créer un post, je dois choisir le nombre de photos à générer, du champs :pictures_generated. Il varie entre 0 et 5 actuellement mais enfaite si j'ai moins de 6 jetons dans mon wallet, je ne peux pas sélectionner 5 par exemple. Je dois donc vérifier le nombre de jetons dans le wallet et le nombre de photos que je peux générer.
  # si j'ai 3 jetons, je peux générer 2 photos max car 1 jeton est utilisé pour créer le brouillon.

  # par défaut, la sélection est sur 0 et pas 1 comme le fait la méthode.

  def options(tokens)
    options = []
    if tokens < 6
      (0..tokens - 1).each do |i|
        options << [i, i]
      end
    else
      options = (0..5).map { |i| [i, i] }
    end
    return options
  end
end
